package de.fau.wisebed.experimentClient

import scala.language.implicitConversions

import org.slf4j.LoggerFactory

import de.fau.wisebed.messages.MessageLogger



object ExpClientPredef {
	
	var e:ExperimentAbs = null
	
	val log = LoggerFactory.getLogger(this.getClass)
	
	def init(conffile: String = "config.xml"){
		e = new ExperimentAbs(conffile)
	}
	
	def resToString() = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.resToString
	}
	
	def allmotes() = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.allmotes
	}
		
	def cleanup(){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.cleanup
	}
	
	def startExp(time:Int, motes:List[String]=null, res_time:Int = 0 ) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.startExp(time, motes, res_time, false)		
	}
	
	
	def startExpAnyway(time:Int, motes:List[String]=null, res_time:Int = 0 ) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.startExp(time, motes, res_time, true)		
		
	}
	
	def getActiveMotes(){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.getActiveMotes
	}
	
	def flash(firmware: String, motes: List[String] = null, trys: Int = 2) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flash(firmware, motes, trys)
	}
	
	
	def resetNodes(trys:Int, startupTime:Int = 0, startupString:String = "Starting", bootTimeout:Int=60, randSeed:Integer = null) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.resetNodes(trys, startupTime, startupString, bootTimeout, randSeed)
	}
	
	def addLogger(logger:MessageLogger) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addLogger(logger)
	}
	
	def addLogLine(file:String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addLogLine(file)
	}
	
	def addMoteLog(basefilename:String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addMoteLog(basefilename)
	}
	
	def addMoteLog(filename: String => String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addMoteLog(filename)
	}
	
	def remLogger(logger:MessageLogger){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.remLogger(logger)
	}
	
	def remLogger(logger:List[MessageLogger]){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.remLogger(logger)
	}
	
	/**
	 * Wait in secs
	 */
	def waitEnd(){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.waitEnd()
		
	}
	
	

}