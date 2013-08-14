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
import de.fau.wisebed.Reservation.reservation2CRD
import de.fau.wisebed.Testbed
import de.fau.wisebed.jobs.Job
import de.fau.wisebed.jobs.MoteAliveState.Alive
import de.fau.wisebed.jobs.MoteFlashState
import de.fau.wisebed.jobs.NodeOkFailJob
import de.fau.wisebed.messages.MessageLogger
import de.fau.wisebed.messages.MessageWaiter
import de.fau.wisebed.messages.MsgLiner
import de.fau.wisebed.wrappers.WrappedChannelHandlerConfiguration
import de.fau.wisebed.wrappers.WrappedChannelHandlerConfiguration.wchc2chc
import de.fau.wisebed.wrappers.WrappedMessage.msg2wmsg

class ExperimentAbs(conffile: String = "config.xml") {
	val log = LoggerFactory.getLogger(this.getClass)
	
	val df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
	
	// Other variables
	var selmotes = List[String]()
	var activemotes = List[String]()
	var reservations = List[de.fau.wisebed.Reservation]()
	var exp:Experiment = null
	var expend:GregorianCalendar = null
	val loggers = ListBuffer[MessageLogger]()
	
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
	
	def cleanup() {
		log.debug("Removing Reservation")
		try {
			reservations.foreach(tb.freeReservation(_))
		} catch {
			case e: Throwable => {
				log.error("Something failed while cleaning up: ", e)
			}
		}
		log.debug("Waiting 4 sec to clean up.")
		Thread.sleep(4000)

	}

	
	def startExp(time:Int, motes:List[String]=null, res_time:Int = 0, takeit:Boolean = false ):Boolean = {
		
		selmotes = {if(motes != null) motes else _allmotes}
		
		if (!reservations.exists(_.now)) {
			log.debug("No Reservations or in the Past- Requesting")
			val from = new GregorianCalendar
			val to = new GregorianCalendar
			from.add(Calendar.MINUTE, -1)
			to.add(Calendar.MINUTE, {if(res_time != 0) res_time else time} + 3)
			val r = tb.makeReservation(from, to, selmotes, "login")
			log.debug("Got Reservations: \n" + r.dateString() + " for " + r.getNodeURNs.mkString(", "))
			reservations ::= r
		}
		
		
		val cr = reservations.find(_.now)
		if(cr.isEmpty){
			log.debug("Unable to get reservation")
			 return false
		}
		
		
		
		val r = cr.get
		val to = new GregorianCalendar
		to.add(Calendar.MINUTE, time)
		expend = to
		if(r.to.before(to)){			
			if(!takeit){
				log.debug("Not able to run experiment in requested time. Reservation end: " + df.format(r.to.getTime) + "Experiment end: " + df.format(to.getTime))
				return false
			} 
			log.debug("Not able to run experiment in requested time. Reservation end: " + df.format(r.to.getTime) + "Experiment end: " + df.format(to.getTime))
			expend = r.to
		}
		
		exp = new Experiment(reservations.toList, tb)
		val statusj = exp.areNodesAlive(selmotes)
		val status = statusj.status
		activemotes = (for ((m, s) <- status; if (s == Alive)) yield m).toList
		if(motes == null){
			selmotes = activemotes
		} else {
			if (!selmotes.forall(activemotes.contains(_))) {
					log.error("Not all motes active. Have: " + activemotes.mkString(", ") + "; Need: " + selmotes.mkString(", ") +
					"; Miss: " + selmotes.filter(!activemotes.contains(_)))
				return false
			}
		}
		val handls = exp.supportedChannelHandlers

		val setHand = "contiki"

		if (handls.find(_.name == setHand) == None) {
			log.error("Can not set handler: " + setHand + " Available: " + handls.map(_.format).mkString(", ") )				
			return false
		} else {
			log.debug("Setting Handler: {}", setHand)
			val chd = exp.setChannelHandler(activemotes, new WrappedChannelHandlerConfiguration("contiki"))
			if (!chd.success) {
				log.error("Failed setting Handler")
				return false
			}
		}

		true
		
		
	}
	
	
	def getActiveMotes:List[String] = activemotes

	def flash(firmware: String, motes: List[String] = null, trys: Int = 2): Boolean = {
		log.debug("Falshing motes.")

		var fmotes = { if (motes != null) motes else activemotes }

		for (t <- 1 to trys) if (fmotes.size > 0) {
			log.debug("Flashing  - try " + t)
			val flashj = exp.flash(firmware, fmotes)
			fmotes = flashj().filter(_._2 != MoteFlashState.OK).map(_._1).toList

			if (fmotes.size > 0) {
				log.error("Failed to flash nodes: " + fmotes.mkString(", "))
			}
		}
		fmotes.size == 0 
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
	
	
	
	def resetNodes(trys:Int, startupTime:Int = 0, startupString:String = "Starting", bootTimeout:Int=60, randSeed:Integer = null): Boolean = {
		val bootupWaiter = new MessageWaiter(selmotes, startupString)
		exp.addMessageInput(bootupWaiter)
		
		log.debug("Resetting nodes")
		var resj: List[Job[_]] = null
		if (startupTime == 0) {
			resj = List(exp.resetNodes(selmotes))

		} else {
			val tm = new Date
			//Make reproduceable
			val rnd = {if(randSeed == null) new Random() else new Random(randSeed)}
			val ftrs = Buffer[Future[NodeOkFailJob]]()

			for (mote <- selmotes) {
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
		if (!bootupWaiter.waitTimeout(bootTimeout * 1000)) {
			bootupWaiter.unregister
			log.error("Failed to Boot")
			return false
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
			import de.fau.wisebed.wrappers.WrappedMessage._
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
		
		for (mote <- selmotes) {
			val out = new java.io.PrintWriter(filename(mote))
			val l = new MessageLogger(mi => {

				import de.fau.wisebed.wrappers.WrappedMessage._
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
	
	
	def waitEnd(){
		var res:Long = 0
		while ({res = getExpTime; res} > 60) {
			log.info("Time left: ~" + (((res - 1) / 60) + 1) + "min");
			Thread.sleep(60 * 1000)
		}
		Thread.sleep(res * 1000)		
	}	
}





