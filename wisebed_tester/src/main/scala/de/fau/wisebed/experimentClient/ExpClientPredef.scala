package de.fau.wisebed.experimentClient

import scala.language.implicitConversions
import org.slf4j.LoggerFactory
import de.fau.wisebed.messages.MessageLogger
import ResFailAction._
import java.io.File


object ExpClientPredef {
	
	var e:ExperimentAbs = null
	
	val log = LoggerFactory.getLogger(this.getClass)
	
	
	/**
	 * Initialize experiment with config file:
	 * {{{
	 * <conf>
	 *	<smEndpointURL>http://somehost:10011/sessions</smEndpointURL> 
	 *	<prefix>urn:fau:</prefix>
	 *	<login>username</login>
	 *	<pass>password</pass>
	 *</conf>
	 * }}}
	 * 
	 */
	def init(conffile: File = new File("config.xml")){
		e = new ExperimentAbs(conffile)
	}
	
	def init(conffile: String) { init(new File(conffile)) }
	
	
	
	
	/**
	 * Print all known reservations as string
	 * @return All reservations as String
	 */
	def resToString() = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.resToString
	}
	


	/**
	 * Start a new Experiment 
	 * @param time The time of the experiment in minutes
	 * @param motes A list of motes to use
	 * @param res_time The time to make a reservation for, if there is no reservation. If this is 0 the reservation will be time + 3 minutes 
	 * @return Success
	 */
	def startExp(time:Int, motes:List[String]=null, res_time:Int = 0 ) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.startExp(time, motes, res_time, Fail)		
	}
	
	/**
	 * Start a new Experiment, but take the reservation even if the reservation slot is not long enaugh 
	 * @param time The time of the experiment in minutes
	 * @param motes A list of motes to use
	 * @param res_time The time to make a reservation for, if there is no reservation. If this is 0 the reservation will be time + 3 minutes 
	 * @return Success
	 */
	def startExpAnyway(time:Int, motes:List[String]=null, res_time:Int = 0 ) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.startExp(time, motes, res_time, TakeIt)		
		
	}
	
	/**
	 * Start a new Experiment. If the current reservation slot is to short or owned by someone else: make a reservation afterwards and wait
	 * @param time The time of the experiment in minutes
	 * @param motes A list of motes to use
	 * @param res_time The time to make a reservation for, if there is no reservation. If this is 0 the reservation will be time + 3 minutes 
	 * @return Success
	 */
	def startExpLater(time:Int, motes:List[String]=null, res_time:Int = 0 ) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.startExp(time, motes, res_time, WaitNext)		
		
	}
	
	
	/**
	 * Get all known nodes
	 * @return A List of all known nodes
	 */
	def allnodes() = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.allnodes
	}
	
	/**
	 * Get a List of active nodes
	 * @return The nodes as URN
	 */
	def getActiveNodes() = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.getActiveNodes
	}
	
	/**
	 * Get a List of active nodes of a certain type
	 * @param nodeTape The nodetype as String
	 * @return The nodes as URN
	 */
	def getActiveNodes(nodeTape:String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.getActiveNodes(nodeTape)
	}
	
	
	/**
	 * Flash firmware
	 * @param firmware Firmware file
	 * @param motes The motes to flash
	 * @param trys Nr of tries before failing
	 * @return Success
	 */
	def flash(firmware: String, motes: List[String] = null, trys: Int = 2) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flash(firmware, motes, trys)
	}
	
	
	/** Flash firmware
	 * @param nodeFirmwareMap A Map where the node maps to the firmware file
	 * @return Success
	 */
	def flash(nodeFirmwareMap:Map[String, String]): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flashMap(nodeFirmwareMap, 2)
	}
	
	/** Flash firmware
	 * @param nodeFirmwareMap A Map where the node maps to the firmware file
	 * @param trys Nr of tries
	 * @return Success
	 */
	def flash(nodeFirmwareMap:Map[String, String], trys: Int): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flashMap(nodeFirmwareMap, trys)
	}
	
	/** Try to flash null firmware to make nodes shut up
	 * @param nodes A List of Nodes
	 * @param trys Nr of tries
	 * @return Success
	 */
	def flashNull(nodes:Seq[String]=null, trys: Int = 2): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.flashNull(nodes, trys)
	}
	
	
	/** Reset nodes - This can be spread 
	 * @param startupTime The time to spread the reset commands in s
	 * @param randSeed A seed to initialize the random number generator
	 * @param startupString  A string to detect that the node successfully booted
	 * @param bootTimeout Time to wait for the startupString
	 * @param trys
	 * @return
	 */
	def resetNodes(startupTime:Int = 0, randSeed:Integer = null, startupString:String = "Starting", bootTimeout:Int=60, trys:Int = 2): Boolean = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.resetNodes(startupTime, randSeed, startupString, bootTimeout, trys)
	}
	
	/** Add a logger
	 * @param logger The logger
	 */
	def addLogger(logger:MessageLogger) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addLogger(logger)
	}
	
	
	def addLogCons() = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addLogCons
	}
	
	/**
	 * Log all output to a File
	 *  - Format: <ms since Epoch>:<node>:<String>
	 *  - Epoch:  January 1, 1970 00:00:00.000 GMT (Gregorian)
	 * @param file The Filename
	 * @return The logger
	 */
	def addLogLine(file:String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addLogLine(file)
	}
	
	
	/** Log output of nodes to separate files
	 *  The incomming data will be dumped without timestamp
	 * @param basefilename The files will be named <basefilename>_<nodename>.log
	 * @return The logger
	 */
	def addMoteLog(basefilename:String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addMoteLog(basefilename)
	}
	
	
	/** Log output of nodes to separate files
	 *  The incoming data will be dumped without timestamp
	 * @param filename A function converting the mote name into a filename
	 * @return The Logger
	 */
	def addMoteLog(filename: String => String) = {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.addMoteLog(filename)
	}
	
	
	/** Remove a logger
	 * @param logger The logger
	 */
	def remLogger(logger:MessageLogger){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.remLogger(logger)
	}
	
	/** Remove logger
	 * @param logger The loggers to remove
	 */
	def remLogger(logger:List[MessageLogger]){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.remLogger(logger)
	}
	
	/** Cleanup: Close connections etc
	 * @param terminate Whether to terminate still running threads. You normally want this.
	 */
	def cleanup(terminate:Boolean = true){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.cleanup(terminate)
	}
	
	
	
	/** Collect data from nodes. It will block until all data was collected
	 * @param command The command to send to the nodes
	 * @param end This must match the end of the answer of the nodes
	 * @param timeout Of long to wait for the answer
	 * @param nodes The nodes to collect the data from
	 */
	def collectData(command:String, end:String, timeout:Int = 5, nodes:Seq[String] = null) {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.collectData(command, end, timeout, nodes)
	}

	/** Reset the starting time of the experiment. This is only important for waitEnd 
	 * @see waitEnd
	 */
	def resetTime() {
		if(e == null) throw new Throwable("Experiment not initialized")
		e.resetTime()
	}
	
	
	/** Send something to the nodes
	 * @param command String to send to the nodes
	 * @param nodes The nodes to send the string to
	 */
	def send(command:String, nodes:Seq[String] = null){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.send(command, nodes)
	}
	

	/** Wait until the end of the expriment
	 * @param cleanup call cleanup at the end
	 * @param leaveTime return leaveTime s before the end of the experiment
	 * @see cleanup
	 * @see resetTime
	 */
	def waitEnd(cleanup:Boolean = true, leaveTime:Int= 0){
		if(e == null) throw new Throwable("Experiment not initialized")
		e.waitEnd(cleanup, leaveTime)
	}
	
	

}