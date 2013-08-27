package de.fau.wisebed.experimentClient

import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.GregorianCalendar
import java.util.Timer
import java.util.TimerTask

import scala.collection.JavaConversions.asScalaBuffer
import scala.collection.JavaConversions.bufferAsJavaList
import scala.collection.JavaConversions.mapAsScalaMap
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Buffer
import scala.collection.mutable.ListBuffer
import scala.concurrent.Await
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.Future
import scala.concurrent.Promise
import scala.concurrent.duration.Duration
import scala.concurrent.future
import scala.util.Random
import scala.util.Success
import scala.xml.XML

import org.slf4j.LoggerFactory

import de.fau.wisebed.Experiment
import de.fau.wisebed.Testbed
import de.fau.wisebed.jobs.Job
import de.fau.wisebed.jobs.NodeAliveState.Alive
import de.fau.wisebed.jobs.NodeFlashState
import de.fau.wisebed.jobs.NodeOkFailJob
import de.fau.wisebed.messages.MessageLogger
import de.fau.wisebed.messages.MessageWaiter
import de.fau.wisebed.messages.MsgLiner
import de.fau.wisebed.wrappers.ChannelHandlerConfiguration
import de.fau.wisebed.WisebedApiConversions._

class ExperimentAbs(conffile: String = "config.xml") {
	val log = LoggerFactory.getLogger(this.getClass)
	
	val df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
	
	// Other variables
	var selNodes = List[String]()
	var activeNodes = List[String]()
	var reservations = List[de.fau.wisebed.Reservation]()
	var exp:Experiment = null
	var expend:GregorianCalendar = null
	val loggers = ListBuffer[MessageLogger]()
	var time = 0;
	
	//Constructor
	
	
	

	log.info("Loading Wisebed config: " + conffile)

	val config = XML.load(conffile)

	val smEndpointURL = (config \ "smEndpointURL").text

	val prefix = (config \ "prefix").text
	val login = (config \ "login").text
	val password = (config \ "pass").text

	//Get Motes
	log.debug("Starting Testbed")
	val tb = new Testbed(smEndpointURL)
	log.debug("Requesting Motes")
	val _allmotes = tb.getNodes() 
	log.debug("Motes: " + _allmotes.mkString(", "))
	log.info("Logging in: \"" + prefix + "\"/\"" + login + "\":\"" + password + "\"")
	tb.addCredencials(prefix, login, password)
	
	
	
	log.debug("Requesting reservations")
	
	reservations = tb.getReservations()
	
	
	
	//Helper
	private def listthreads() {
		val st = Thread.getAllStackTraces

		for (t <- st) {
			if (t._1.isDaemon()) {
				println("Deamon: " + t._1.toString)
			} else {
				println("Thread: " + t._1.toString)
				t._2.foreach(println(_))
			}
		}
	}
	
	
	//Functions
	def resToString():List[String] = {
		val rv = ArrayBuffer[String]()
		
		for(r <- reservations) {
			rv.add("Got Reservations: " + r.dateString() + " for " + r.getNodeURNs.mkString(", ") + " from " + df.format(r.from.getTime) + " to " + df.format(r.to.getTime))
		}
		rv.toList
	}
	
	def allmotes = _allmotes
	

	
	/**
	 * @param time Time in minutes
	 * @param motes The Motes to use
	 * @param res_time Time to make reservation if none exists
	 * @param takeit Take the reservation if it it ends before time
	 * @return True on success
	 */
	def startExp(time:Int, nodes:List[String]=null, res_time:Int = 0, takeit:Boolean = false ):Boolean = {
		this.time = time;
		selNodes = {if(nodes != null) nodes else _allmotes}
		
		val curres = reservations.find(_.now)
		
		if(curres.isEmpty) {
			log.debug("No Reservations or in the Past- Requesting")
			val from = new GregorianCalendar
			val to = new GregorianCalendar
			from.add(Calendar.SECOND, -2)
			to.add(Calendar.MINUTE, {if(res_time != 0) res_time else time} + 3)
			val r = tb.makeReservation(from, to, selNodes, "login")
			log.debug("Got Reservations: \n" + r.dateString() + " for " + r.nodeURNs.mkString(", "))
			reservations ::= r
		} else if(!curres.get.mine) {			
			throw new Exception("Someone els has an reservation")
		}
		
		
		val cr = reservations.find(_.now)
		if(cr.isEmpty){
			throw new Exception("Unable to get reservation")

		}
		
		
		
		val r = cr.get
		val to = new GregorianCalendar
		to.add(Calendar.MINUTE, time)
		expend = to
		if(r.to.before(to)){			
			if(!takeit){
				throw new Exception("Not able to run experiment in requested time. Reservation end: " + df.format(r.to.getTime) + "Experiment end: " + df.format(to.getTime))				
			} 
			log.debug("Not able to run experiment in requested time. Reservation end: " + df.format(r.to.getTime) + "Experiment end: " + df.format(to.getTime))
			expend = r.to
		}
		
		exp = new Experiment(reservations.toList, tb)
		val statusj = exp.areNodesAlive(selNodes)
		val status = statusj.status
		log.debug("Nodes:\n" +
				status.map(x => {x._1 + " -> " + x._2}).mkString("\n"))
		activeNodes = status.filter(_._2 == Alive).map(_._1).toList
		if(nodes== null){
			selNodes = activeNodes
			log.info("No nodes preselected. Using all active nodes: " + selNodes.mkString(", "))
			
		} else {
			if (!selNodes.forall(activeNodes.contains(_))) {
					log.error("Not all motes active. Have: " + activeNodes.mkString(", ") + "; Need: " + selNodes.mkString(", ") +
					"; Miss: " + selNodes.filter(!activeNodes.contains(_)))
				return false
			}
		}
		if(selNodes.size == 0) {
			log.error("State of nodes: \n" + status.map(x => {x._1 + ": " + x._2}).mkString("\n") )
			throw new Exception("No node selected")
		}
		
		val handls = exp.supportedChannelHandlers

		val setHand = "contiki"

		if (handls.find(_.name == setHand) == None) {
			log.error("Can not set handler: " + setHand + " Available: " + handls.map(_.format).mkString(", ") )				
			return false
		} else {
			log.debug("Setting Handler: {}", setHand)
			val chd = exp.setChannelHandler(activeNodes, new ChannelHandlerConfiguration("contiki"))
			if (!chd.success) {
				log.error("Failed setting Handler")
				return false
			}
		}

		true
		
		
	}
	
	
	def getActiveNodes:List[String] = activeNodes
	
	def getActiveNodes(nodeType:String):List[String] = {
		activeNodes.filterNot(tb.getNode(nodeType).contains(_))
	}

	def flash(firmware: String, nodes: Seq[String] = null, trys: Int = 2): Boolean = {
		log.debug("Falshing motes.")

		var fnodes = { if (nodes != null) nodes else activeNodes }

		for (t <- 1 to trys) if (fnodes.size > 0) {
			log.debug("Flashing  - try " + t)
			val flashj = exp.flash(firmware, fnodes)
			fnodes = flashj().filter(_._2 != NodeFlashState.OK).map(_._1).toList

			if (fnodes.size > 0) {
				log.error("Failed to flash nodes: " + fnodes.mkString(", "))
			}
		}
		fnodes.size == 0 
	} 
	
	def flashMap(nodeFirmwareMap:Map[String, String], trys: Int = 2): Boolean = {
		log.debug("Flashing motes.")

		var fnodes = collection.mutable.Map(nodeFirmwareMap.toSeq: _*) 

		for (t <- 1 to trys) if (fnodes.size > 0) {
			log.debug("Flashing  - try " + t)
			val flashj = exp.flash(fnodes)
			fnodes --= flashj().filter(_._2 == NodeFlashState.OK).map(_._1).toList
			if (fnodes.size > 0) {
				log.error("Failed to flash nodes: " + fnodes.mkString(", "))
			}
		}
		fnodes.size == 0 
	}
	
	
	def flashNull(nodes:Seq[String]=null, trys: Int = 2): Boolean = {
		import de.fau.wisebed.wrappers.Program
		var fnodes = { if (nodes != null) nodes else activeNodes }
		val wnodes= tb.getNode
		var progmap = collection.mutable.Map[String,(Program, collection.mutable.Buffer[String])]()

		log.debug("Wnodes \n" + wnodes.map(x=> (x.id + " -> " + x.nodeType)).mkString("\n"));
		
		for(n <- fnodes) {
			log.debug("Node:" + n)
			val nd = wnodes.find(_.id == n).get			
			val rp = progmap.getOrElseUpdate(nd.nodeType, {
				val fmrs = this.getClass.getResourceAsStream("/nullfirmware/" + nd.nodeType + ".hex")
				if(fmrs == null) throw new Exception("No Nullfirmware for NodeType " + nd.nodeType)
				log.debug("Adding Firmaware for" + nd.nodeType)
				Program(fmrs, "Nullfirmware " + nd.nodeType ) -> Buffer[String]()				
			})
			rp._2 += n
		}
		
		var pmap = progmap.values.toList
		for((prg, mt)  <- pmap) {
			var tfnodes = mt
			for (t <- 1 to trys) if (tfnodes.size > 0) {
				log.debug("Flashing  - try " + t)
				val flashj = exp.flash(prg,tfnodes)
				tfnodes --= flashj().filter(_._2 == NodeFlashState.OK).map(_._1).toList
				if (tfnodes.size > 0) {
					log.error("Failed to flash nodes: " + tfnodes.mkString(", "))
				}
			}
		}
		
		
		/*
		 * This is currently Broken in wisebed 
		
		
		log.debug("PMap \n" + pmap.map(x=> (x._1 + " -> " + x._2)).mkString("\n"));
		log.debug(pmap.map(x => {x._1.name + " -> " + x._2.mkString(", ")}).mkString("\n"))
		
		for (t <- 1 to trys) if (pmap.size > 0) {
			log.debug("Flashing Nullfirmware  - try " + t)
			
			val flashj = exp.flash(pmap.map(x=>{x._1 -> x._2.toSeq }).toMap)
			val sucn = flashj().filter(_._2 != NodeFlashState.OK).map(_._1).toList
			pmap = pmap.map(x => (x._1 -> x._2.filter(sucn.contains(_)))).filter(_._2.size == 0)
		}
		*/
		fnodes.size == 0 
	}
	
	val fb = Buffer[Future[Boolean]]()
	
	def flashAsync(firmware: String, motes: List[String] = null, trys: Int = 2): Future[Boolean] = {
		val ftr:Future[Boolean] = future {
			flash(firmware, motes, trys)
		}
		fb += ftr
		ftr	
	}
	

	/**
	 * Wait for all async flash processes to end
	 * @param d Maximum duration to wait
	 * @return true on success
	 */
	def flashWaitDone(d: Duration = Duration.Inf) = {
		var rv = true
		for(f <- fb){
			val r = Await.result(f, d)
			if(!r) rv = false
			fb -= f
		}
		rv
	}
	
	
	/**
	 * Reset the nodes.
	 * @param startupTime The range in which the nodes are reset
	 * @param randSeed
	 * @param startupString
	 * @param bootTimeout
	 * @param trys
	 * @param resetTime
	 * @return
	 */
	def resetNodes(startupTime:Int = 0, randSeed:Integer = null, startupString:String = "Starting", bootTimeout:Int=60, trys:Int = 2): Boolean = {
		val bootupWaiter = new MessageWaiter(selNodes, startupString)
		exp.addMessageInput(bootupWaiter)
		
		log.debug("Resetting nodes")
		var resj: List[Job[_]] = null
		if (startupTime == 0) {
			resj = List(exp.resetNodes(selNodes))

		} else {
			val tm = new Date
			//Make reproduceable
			val rnd = {if(randSeed == null) new Random() else new Random(randSeed)}
			val ftrs = Buffer[Future[NodeOkFailJob]]()

			for (mote <- selNodes) {
				val restm = new Date(tm.getTime + 1000 + (rnd.nextInt % (startupTime * 1000)))
				val prom = Promise[NodeOkFailJob]()
				val ftr = new TimerTask {
					def run = prom.complete(new Success(exp.resetNodes(List(mote))))
				}
				ftrs += prom.future
				val tmr = new Timer(true)
				tmr.schedule(ftr, restm)
			}
			//Get jobs from futures
			resj = ftrs.map(Await.result(_, Duration.Inf)).toList

		}
		if (!resj.forall(_.success)) {
			log.error("Failed to reset nodes")
			return false
		}
		

		log.debug("Waiting for bootup")
		if (!bootupWaiter.waitResult(bootTimeout * 1000)) {
			bootupWaiter.unregister
			log.error("Failed to Boot")
			cleanup(true)
		}
		
		true
	}

	
	def addLogger(logger:MessageLogger) = {
		exp.addMessageInput(logger)
		loggers += logger
		logger
	}
	
	def addLogLine(file:String):MessageLogger = {
		val out = new java.io.PrintWriter(file)
		
		val logger = new MessageLogger(mi => {
			out.println(mi.node + ": " + mi.dataString)
			out.flush
		}) with MsgLiner
		
		logger.runOnExit({ out.close })
		exp.addMessageInput(logger)
		loggers += logger
		logger
	}

	def addMoteLog(basefilename:String):List[MessageLogger] = {
		addMoteLog(m => basefilename + "_" + m + ".log")
	}
	
	def addMoteLog(filename: String => String):List[MessageLogger] = {
		val logger = ListBuffer[MessageLogger]()
		
		for (mote <- selNodes) {
			val out = new java.io.PrintWriter(filename(mote))
			val l = new MessageLogger(mi => {

				if (mi.node == mote) {
					out.print(mi.dataString)
					out.flush
				}
			})
			l.runOnExit({ out.close })
			exp.addMessageInput(l)
			logger.add(l)
		}
		loggers ++= logger
		logger.toList
	}
	
	
	def remLogger(logger:MessageLogger){
		remLogger(List(logger))
	}
	
	
	def remLogger(logger:List[MessageLogger]){
		for(l <- logger){
			exp.remMessageInput(l)
			loggers -= l
		}
		
	}	
	
	private def getExpTime = (expend.getTimeInMillis - System.currentTimeMillis) / 1000
	
	
	def resetTime() {
		val to = new GregorianCalendar
		to.add(Calendar.MINUTE, time)
		expend = to
	}

	def send(command:String, nodes:Seq[String] = null){
		val nts = {if(nodes != null) nodes else activeNodes }	
		exp.send(nts, command)
	}

	
	/**
	 * @param command The command to send to the nodes
	 * @param end A string to determin the end of the output data
	 * @param timeout The timeout in seconds
	 * @param motes The motes to apply this to. If it is null all active motes are used
	 * @return true on success
	 * @return false if timed out
	 */
	def collectData(command:String, end:String, timeout:Int = 5, nodes:Seq[String] = null):Boolean = {
		val nts = {if(nodes != null) nodes else activeNodes }	
		val mw = new MessageWaiter(nts, end);
		exp.addMessageInput(mw)
		send(command, nts)
		import scala.concurrent.duration._
		val f= mw.waitResult(Duration(timeout, SECONDS))
		if(!f) {
			log.info("Failed to collect results")
		}
		f

	}
	
	
		
	def cleanup(terminate:Boolean = true) {
		log.debug("Cleanup")
		val cr = reservations.find(_.now)
		if (!cr.isEmpty) {
			tb.freeReservation(cr.get)
		}

		Thread.sleep(1000 * 2)

		var mustExit = false
		val st = Thread.getAllStackTraces
		for (t <- st) {
			if (t._1 == Thread.currentThread) {}
			else if (t._1.isDaemon()) {
				log.debug("Deamon: " + t._1.toString)

			} else {
				log.debug("Thread: " + t._1.toString + "\n" + t._2.mkString("\n"))
				mustExit = true
			}
		}
		if (mustExit) sys.exit(2)
	}
	
	
	def waitEnd(cleanup:Boolean = true, leaveTime:Int= 0){
		var res:Long = 0
		while ({res = getExpTime - leaveTime; res} >= 60) {
			log.info("Time left: ~" + (((res - 1) / 60) + 1) + "min");
			Thread.sleep(60 * 1000)
		}
		log.info("Time left: ~" + (((res - 1) / 60) + 1) + "min");
		Thread.sleep(res * 1000)
	
			
		if(cleanup) {
			this.cleanup()
		}
	}
			
}





