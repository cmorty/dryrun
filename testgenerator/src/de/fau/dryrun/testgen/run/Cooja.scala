package de.fau.dryrun.testgen.run


import de.fau.dryrun.testgen._
import java.io.File
import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer
import scala.util.Random

object Cooja {
	var coojapath = "cooja"
}

class Cooja(sim:String)(implicit val conf:Config) extends Step {
	
	val files = Set[String]()
	files += "COOJA.log"
	files += "COOJA.testlog"
	var coojaconf:String = null
	var log4jconf:String= null
	var random =  new ArrayBuffer[Long](-1)
	
	/**
	 * Add file to save after run.
	 */
	def addfile(f:String){
		files += f
	}
	/*
	def addRand(name:String, options:String*){
		val opt = options.toSet
		flags.add(name, opt)
	} */
	
	
	/**
	 * Add random seed
	 */
	def addRand(seed:Long*){
		random -= -1
		random ++= seed
	}
	
	/**
	 * Add a range of seeds
	 */
	def addRandRange(start:Long, stop:Long, step:Long = 1){
		val r = Range.Long(start, stop + 1, step)
		addRand(r.toList:_*)
	}
	
	
	/**
	 * Generate random seeds based on seed
	 */
	def addRandSet(seed:Int, quantety: Int){
		val r = new Random(seed)
		for(foo <- 0 to quantety){
			addRand(r.nextLong)
		}
	}

	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		println("Number of seeds: " + random.size)
		val rv = new ArrayBuffer[Experiment]
		for(exp<-exps;
			seed <- random){

			val cexp = exp.copy
			cexp.addConfig("seed",seed.toString, random.length == 1, true)
			cexp.addName("seed:" + seed.toString)
			
			cexp.addcommand(new Command {
				def getcmd()(implicit exp: Experiment):String = {
					var crv = ""
					val simp:String = {
						if(random != -1){
							val destsim:String = exp.chroot + "/" + new File(sim).getName
							crv += "xmlstarlet ed -u  \"/simconf/simulation/randomseed\" -v \""  + seed.toString + "\" " + sim + " > " + destsim  + "\n"
							destsim
						} else {
							sim
						}
					}
					
					//rv += "cp 
					crv += "cd " + exp.chroot + "&&  " + Cooja.coojapath + " -nogui=" + simp 
					if(coojaconf != null) crv += " -external_tools_config=" + coojaconf 
					if(log4jconf != null) crv += " -log4j=" + log4jconf 
					crv += "\n"
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

