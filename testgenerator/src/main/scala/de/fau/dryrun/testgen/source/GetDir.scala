package de.fau.dryrun.testgen.source

import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen._
import scala.collection.mutable.ArrayBuffer


object GetDir {
	var cp = "cp -r"
}


class GetDir(source:String, dest:String = ".")(implicit conf: Config) extends GetFile(source, dest) {

	override 
	protected val cpycmd = new Command {
		def getcmd()(implicit exp: Experiment):String = {
			GetDir.cp + " " + source + " " + exp.chroot + "/" + dest + "\n"
		}
	}
	

}
