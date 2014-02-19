package de.fau.dryrun.testgen

import scala.collection.mutable.ArrayBuffer

abstract class Step {
	
	protected [testgen] def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment]	
	
	
}