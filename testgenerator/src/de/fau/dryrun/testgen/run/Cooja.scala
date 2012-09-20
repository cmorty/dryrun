package de.fau.dryrun.testgen.run


import de.fau.dryrun.testgen._
import java.io.File
import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer

object Cooja {
	var coojapath = "cooja"
}

class Cooja(sim:String)(implicit val conf:Config) extends Step {
	var resultpath = "results"
	val files = Set[String]()
	files += "COOJA.log"
	files += "COOJA.testlog"
	var coojaconf = "config/testenv.config"
	var log4jconf="$(LOG4JCONFIG)"
		
	def addfile(f:String){
		files += f
	}
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		for(exp<-exps){
			exp.addcommand(new Command {
				def getcmd()(implicit exp: Experiment):String = {
					var rv = ""
					//rv += "cp 
					rv += "cd " + exp.chroot + "&&  " + Cooja.coojapath + " -nogui="+sim + " -external_tools_config=" + coojaconf + " -log4j=" + log4jconf + " " + "\n"
					for(f <- files){
						rv += "mkdir -p " + exp.datapath + "/" + resultpath + "\n"
						rv += "cp " + exp.chroot + "/" + f + " " + exp.datapath + "/" + resultpath + "\n"
					}
					
					rv	
				}
			})
		}
		exps 
	}

}

