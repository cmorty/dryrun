package de.fau.dryrun.testgen

abstract class Command {
	def getcmd()(implicit exp: Experiment):String
	
	def finish()(implicit exp: Experiment){}
}