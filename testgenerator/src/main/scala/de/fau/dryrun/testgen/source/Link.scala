package de.fau.dryrun.testgen.source

import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen._
import scala.collection.mutable.ArrayBuffer


object Link {
	var ln = "ln -s"
}


class Link(source:String, dest:String)(implicit conf: Config) extends Step {

	
	val cpycmd = new Command {
		def getcmd()(implicit exp: Experiment):String = {
			Link.ln + " " + source + " " + exp.chroot + "/" + dest + "\n"
		}
	}
	
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		for(exp <- exps) exp.addcommand(cpycmd) 
		exps
	}
	
	
	def setln(ln:String) {
		Link.ln = ln
	}  

}