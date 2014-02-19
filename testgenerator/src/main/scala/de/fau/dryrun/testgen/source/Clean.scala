package de.fau.dryrun.testgen.source

import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen._
import scala.collection.mutable.ArrayBuffer


object Clean {
	var rm = "rm -rf "
}


class Clean(dest:String)(implicit conf: Config) extends Step {

	
	val rmcmd = new Command {
		def getcmd()(implicit exp: Experiment):String = {
			Clean.rm + "  " + exp.chroot + "/" + dest + "\n"
		}
	}
	
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		for(exp <- exps) exp.addcommand(rmcmd) 
		exps
	}
	
	
	
	
	def setrm(rm:String) {
		Clean.rm = rm
	}  

}