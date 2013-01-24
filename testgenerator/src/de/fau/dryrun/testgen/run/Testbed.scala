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
	
}

class Testbed(val firmware:String)(implicit val conf:Config) extends Step {
	
	var setfile = "config/settings.xml" 
			
	val nodes = Set[String]()
	
	var startup = 4
	var rand = 0
		
		
	val files = Set[String]()
	files += "*.log"
	var random =  new ArrayBuffer[Long](-1)
		
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
		println("Number of seeds: " + random.size)
		val rv = new ArrayBuffer[Experiment]
		for(exp<-exps;
			seed <- random){

			val cexp = exp.copy
			cexp.addConfig("seed",seed.toString, (exp == -1))
			cexp.addName("seed:" + seed.toString)
			
			cexp.addcommand(new Command {
				def getcmd()(implicit exp: Experiment):String = {
					//Generate config
					
					val xmld = <exp>
								<time>360</time>
								<firmware>{exp.chroot + "/" + firmware}</firmware>
								{ nodes.map(x => <mote>{x}</mote>)}
								<runs>
									<num>1</num>
									<startup>{startup}</startup>
									<rand>{seed}</rand>
								</runs>
							</exp>
					
					XML.save(exp.datapath + "/exp.xml"  , xmld)
					var crv = ""					
					//rv += "cp 
					crv += "cd " + exp.chroot + " && java -jar " + Testbed.expclientpath + " " + exp.datapath + "/exp.xml"  + " " + setfile + "\n"
					for(f <- files){
						crv += "mkdir -p " + exp.datapath + "/" + conf.resultpath + "\n"
						crv += "cp " + exp.chroot + "/" + f + " " + exp.datapath + "/" + conf.resultpath + "\n"
					}
					crv	
				}
			})
			rv += cexp
		}
		
		rv
	}
		

	
}