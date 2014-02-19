package de.fau.dryrun.testgen


import scala.tools.nsc._
import scala.tools.nsc.interpreter._
import java.io.File
import java.io.BufferedReader
import java.io.FileReader

object Client {

	
	
	 def  main(args: Array[String]) {
		
		 
		 
		if(args.length != 1){
			printf("Wrong number of arguments.\n")
			sys.exit(1)
		}
	  
		val f = new File(args(0)); 
		
		if(! f.exists() ){
			printf("Config file not found.")
		}
		
		
		val input = new BufferedReader( new FileReader(f))
		
		
		val settings = new Settings
		val compilerPath = java.lang.Class.forName("scala.tools.nsc.Interpreter").getProtectionDomain.getCodeSource.getLocation
		val libPath = java.lang.Class.forName("scala.Some").getProtectionDomain.getCodeSource.getLocation
		
		settings.bootclasspath.value = List(settings.bootclasspath.value, compilerPath, libPath) mkString java.io.File.pathSeparator

		println("compilerPath=" + compilerPath);
		println("settings.bootclasspath.value=" + settings.bootclasspath.value);

		    
		settings.usejavacp.value = true

		val sI = new IMain(settings)
		//Add imports
		sI.addImports("de.fau.dryrun.testgen.Config");
		sI.addImports("de.fau.dryrun.testgen.source._");
		sI.addImports("de.fau.dryrun.testgen.run._");
		sI.interpret("val testpath = \"" + f.getCanonicalFile().getParent() + "\"\n")
		
		var line = 1
		var str:String = null
		val lines = scala.io.Source.fromFile(f).mkString
		sI.interpret(lines)
		

		println("\n\nDone\n\n");
		
	}

}