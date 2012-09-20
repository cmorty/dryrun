package de.fau.dryrun.testgen

import scala.collection.mutable.ArrayBuffer

abstract class Step {
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment]	
	
	
}