package de.fau.dryrun.testgen.source

import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen._
import scala.collection.mutable.ArrayBuffer




class GetFile(source:String, dest:String = ".")(implicit conf: Config) extends Step {

	
	protected val cpycmd = new Command {
		def getcmd()(implicit exp: Experiment):String = {
			GetDir.cp + " " + source + " " + exp.chroot + "/" + dest + "\n"
		}
	}
	
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		for(exp <- exps) exp.addcommand(cpycmd) 
		exps
	}
	
	
	def setcp(cp:String) {
		GetDir.cp = cp
	}  

}
object GetFile {
	private var cp = "cp"
}
