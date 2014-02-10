package de.fau.wisebed.experimentClient

import java.io.BufferedReader
import java.io.File
import java.io.FileReader
import scala.tools.nsc._
import scala.tools.nsc.interpreter.IMain
import java.util.jar.Manifest
import scala.collection.mutable.Buffer
import scala.tools.nsc.interpreter.Results
import java.io.StringWriter
import java.io.PrintWriter
import org.slf4j.LoggerFactory
import java.net.URLClassLoader
import commands._
import org.apache.log4j.Logger
import org.apache.log4j.Level


case class Config(
		cmd:Config => Command = null,
		file:File = null ,
		val confFile:File = new File("./config.xml"),
		loglevel:Level=Level.WARN
)

class Command(conf:Config);


object Client {

	
	val dlevels = List("OFF", "FATAL", "ERROR", "WARN", "INFO", "DEBUG", "ALL")

	
	def main(args: Array[String]) {
		val log = LoggerFactory.getLogger(this.getClass)
		de.fau.wisebed.util.Logging.setDefaultLogger
		
		
		val parser = new scopt.OptionParser[Config]("Wisebed Client") {
			
			
			opt[File]('c', "conf")
				.action { (x, c) => c.copy(confFile = x) }
				.text("An alternative configuration file. The default is \"" + (new Config).confFile + "\"")
				
			opt[String]('d', "debug")
				.action { (x, c) => c.copy(loglevel = Level.toLevel(x)) }
				.validate(x => if(Level.toLevel(x) != null) success else failure("Unknown Loglevel: " + x))
				.text("Loglevel: " + dlevels.mkString(", "))
				
			opt[Unit]('v', "verbose")
				.action { (x, c) => c.copy(loglevel = Level.DEBUG) }
				.text("alias for -d DEBUG")
			
			
			cmd("run") 
				.action { (_, c) =>  c.copy(cmd = x => new Run(x)) } 
				.text("Run a script")
				.children(
						arg[File]("<file>")
						.action { (x, c) =>  c.copy(file = x) }
						.text("File to run")
				)
				
				
			cmd("list")
				.action { (_, c) =>  c.copy(cmd = x => new List(x)) }
				.text("List nodes")
				
			cmd("state")
				.action { (_, c) =>  c.copy(cmd = x => new NodeState(x)) }
				.text("Get Node states")
				
			checkConfig { c => if(c.cmd == null) failure("Missing command") else success}
		}

		
		
		parser.parse(args, Config())map { cnf =>
			Logger.getRootLogger.setLevel(cnf.loglevel)
			cnf.cmd(cnf)
		} getOrElse {		  
		}
		
	
		


	}

}
