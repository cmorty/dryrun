package de.fau.dryrun.testgen.run


import de.fau.dryrun.testgen._
import java.io.File
import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer
import scala.util.Random
import scala.collection.mutable.Buffer
import scala.xml.XML


object Wisebed1{
	var expclientpath = "expclient"
	private var suffxs = Buffer[String]()
}

class Wisebed1(val defaultFirmware:String = null)(implicit val conf:Config) extends Step {
	
	var setfile = "config/settings.xml" 
			
	val nodes = Set[String]()
	
	var startup = 4
	var rand = 0
	var time = 20
	val firmware = scala.collection.mutable.Map[String, String]()
	val defaultNodeFirmware = scala.collection.mutable.Map[String, String]()
	var runScript = "waitEnd()\n" 
	var bootString = "Rime started"
		
	val files = Set[String]()
	files += "*.log"
	var random =  new ArrayBuffer[Long]()
	random += -1
	
	var suffix = ""
		
	def addfile(f:String){
		files += f
	}

	def addFirmware(node:String, file:String) {addFirmware(List(node), file)}		
	
	def addFirmware(nodes:List[String], file:String){		
		for(m <- nodes){
			firmware.update(m, file)
		}
	}
	
	def addDefaultFirmware(nodeType:String, file:String) {
		defaultNodeFirmware.update(nodeType, file)
	}
	
	def addRand(seed:Long*){
		random -= -1
		random ++= seed
	}
	
	def addRandRange(start:Long, stop:Long, step:Long = 1){
		val r = Range.Long(start, stop + 1, step)
		addRand(r.toList:_*)
	}
	
	def addRandSet(seed:Int, quantety: Int){
		val r = new Random(seed)
		for(foo <- 0 to quantety){
			addRand(r.nextLong)
		}
	}
	
	
	def addNode(node:String *){
		nodes ++= node
	}
	

	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		implicit def tuple2ToList[T](t: (T,T)): List[T] = List(t._1, t._2)
		
		println("Number of seeds: " + random.size)
		val rv = new ArrayBuffer[Experiment]

		
		//Get Suffix if needed
		var ctr = 0;
		while(Wisebed1.suffxs.find(_ == suffix) != None){
			suffix = ctr.toString
			ctr += 1
		}
		
		
		for(exp<-exps;
			seed <- random){

			val cexp = exp.copy
			cexp.addConfig("seed",seed.toString, random.length == 1, true)
			cexp.addName("seed:" + seed.toString)
			
			cexp.addcommand(new Command {


				Wisebed1.suffxs += suffix
				
				def getcmd()(implicit exp: Experiment):String = {
					//Generate config
						
					
					val cmd = """
init("""" + setfile+ """")
startExp(""" + time + "," + {if(nodes.size == 0 ) "null" else nodes.mkString("List(\"", "\", \"", "\")")  } + ","+ {(time + 6) *  Experiment.count} + """)
log.info("Res: " + resToString.mkString("\n"))
var fmap = Map[String, String]()
""" + {
	var str = ""
	//Fill with default firmware
	if(defaultFirmware !=  null) str += "fmap = fmap ++ getActiveNodes.map(_ -> \"udp-client.ihex\").toMap\n"
	
	//Overwrite with nodeType firmware
	for((mType, fw) <- defaultNodeFirmware) {
		str += "fmap = fmap ++ getActiveNodes(\"" + mType + "\").map(_ -> \"" + fw + "\").toMap\n"
	}

	//Overwrite with node specific firmware
	
	str += "fmap = fmap ++ Map(" + { firmware.map(x => {'"' + x._1 + "\" -> \"" + x._2 + '"'}).mkString(", ")} + ")\n"	
	str
} + """
flash(fmap)
addLogLine("wisebed.log")
val rsn = resetNodes(""" + startup + ", " + seed +  ", \"" + bootString +"\"" + """)
if(!rsn) cleanup(true)
resetTime()
""" + runScript		
					
					val pw = new java.io.PrintWriter(new File(exp.datapath + "/exp" + suffix + ".ec"))				    
					pw.write(cmd)
			      	pw.close()
				    
					var crv = ""					
					//rv += "cp 
					crv += "cd " + exp.chroot + " && java -jar " + Wisebed1.expclientpath + " " + exp.datapath + "/exp" + suffix + ".ec"  + "\n"
					for(f <- files){
						crv += "mkdir -p " + exp.datapath + "/" + conf.resultpath  + "/" + suffix +  "\n"
						crv += "cp " + exp.chroot + "/" + f + " " + exp.datapath + "/" + conf.resultpath + "/" + suffix +  "/\n"
					}
					crv	
				}
			})
			rv += cexp
		}
		
		rv
	}
		

	
}