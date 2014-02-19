package de.fau.dryrun.testgen.run


import de.fau.dryrun.testgen._
import java.io.File
import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer
import scala.util.Random
import scala.collection.mutable.Buffer
import scala.xml.XML


object Testbed{
	var expclientpath = "expclient"
	private var suffxs = Buffer[String]()
}

class Testbed(val firmware:String)(implicit val conf:Config) extends Step {
	
	var setfile = "config/settings.xml" 
			
	val nodes = Set[String]()
	
	var startup = 4
	var rand = 0
	var time = 360
		
	val files = Set[String]()
	files += "*.log"
	var random =  new ArrayBuffer[Long](-1)
	
	var suffix = ""
		
	def addfile(f:String){
		files += f
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
	
	
	def addNode(mote:String *){
		nodes ++= mote
	}
	

	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		implicit def tuple2ToList[T](t: (T,T)): List[T] = List(t._1, t._2)
		
		println("Number of seeds: " + random.size)
		val rv = new ArrayBuffer[Experiment]

		
		//Get Suffix if needed
		var ctr = 0;
		while(Testbed.suffxs.find(_ == suffix) != None){
			suffix = ctr.toString
			ctr += 1
		}
		
		
		for(exp<-exps;
			seed <- random){

			val cexp = exp.copy
			cexp.addConfig("seed",seed.toString, random.length == 1, true)
			cexp.addName("seed:" + seed.toString)
			
			cexp.addcommand(new Command {


				Testbed.suffxs += suffix
				
				def getcmd()(implicit exp: Experiment):String = {
					//Generate config
					
					val xmld = <exp>
								<time>{time}</time>
								<firmware>{exp.chroot + "/" + firmware}</firmware>
								{ nodes.map(x => <mote>{x}</mote>)}
								<runs>
									<num>1</num>
									<startup>{startup}</startup>
									<rand>{seed}</rand>
								</runs>
							</exp>
					
					XML.save(exp.datapath + "/exp" + suffix + ".xml"  , xmld)
					var crv = ""					
					//rv += "cp 
					crv += "cd " + exp.chroot + " && java -jar " + Testbed.expclientpath + " " + exp.datapath + "/exp" + suffix + ".xml"  + " " + setfile + "\n"
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