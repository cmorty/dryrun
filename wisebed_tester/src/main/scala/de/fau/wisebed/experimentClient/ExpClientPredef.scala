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
		

	def startExp(time:Int, motes:List[String]=null, res_time:Int = 0 ) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.startExp(time, motes, res_time, false)		
	}
	
	
	def startExpAnyway(time:Int, motes:List[String]=null, res_time:Int = 0 ) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.startExp(time, motes, res_time, true)		
		
	}
	
	def getActiveNodes() = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.getActiveNodes
	}
	
	def getActiveNodes(nodeTape:String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.getActiveNodes(nodeTape)
	}
	
	def flash(firmware: String, motes: List[String] = null, trys: Int = 2) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flash(firmware, motes, trys)
	}
	
	
	def flash(nodeFirmwareMap:Map[String, String]): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flashMap(nodeFirmwareMap, 2)
	}
	
	def flash(nodeFirmwareMap:Map[String, String], trys: Int): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flashMap(nodeFirmwareMap, trys)
	}
	
	def flashNull(nodes:Seq[String]=null, trys: Int = 2): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flashNull(nodes, trys)
	}
	
	
	def resetNodes(startupTime:Int = 0, randSeed:Integer = null, startupString:String = "Starting", bootTimeout:Int=60, trys:Int = 2): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.resetNodes(startupTime, randSeed, startupString, bootTimeout, trys)
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
	
	def cleanup(terminate:Boolean = true){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.cleanup(terminate)
	}
	
	
	def collectData(command:String, end:String, timeout:Int = 5, nodes:Seq[String] = null) {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.collectData(command, end, timeout, nodes)
	}
	
	def resetTime() {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.resetTime()
	}
	
	
	def send(command:String, nodes:Seq[String] = null){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.send(command, nodes)
	}
	
	
	/**
	 * Only wait to the end of the experiement or also terminate the session?
	 */
	def waitEnd(cleanup:Boolean = true, leaveTime:Int= 0){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.waitEnd(cleanup, leaveTime)
	}
	
	

}