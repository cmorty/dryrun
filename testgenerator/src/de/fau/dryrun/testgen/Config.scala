package de.fau.dryrun.testgen


import scala.collection.mutable.ArrayBuffer
import java.io.BufferedWriter
import java.io.FileWriter
import java.io.File






class Config {
	
	
	
	var outdir = "/tmp/dryrun/tests"
	var workdir = "/tmp/dryrun/work" 	
		
	implicit val config = this
		
	var head:Step = null
	var last:Step = null
	
	val steps = new ArrayBuffer[Step]
	
	// TODO: Test whether chroot exists
	
	def addstep(step : Step){
		steps += step
		println("Added step: " + step)
		
	}
		
	
	
	
	def generate {
		println("running")
		var exps = new ArrayBuffer[Experiment]
		exps += new Experiment
		
		for(step <- steps){
			println("registering step: " + step)
			exps = step.registerExperiment(exps)
			println("Number of experiments: " + exps.size )
		}
		
		val pfile =  new File(outdir + "/parallel.jobs")
		new File(outdir).mkdirs();
			
		val outp  = new BufferedWriter(new FileWriter(pfile))
		
		
		for(exp <- exps){
			val d = new File(exp.datapath)
			d.mkdirs
			val of = new File(d.toString() + "/" + "exp.sh")
			val out = new BufferedWriter(new FileWriter(of))		
			//printf("--- " +exp.name+" ---\n%s-------\n" , exp.getcmds)
			
			outp.write("\"" + of.toString() + "\" 1>\"" + d.toString() + "/" + "exp.log\" 2>&1\n" )
			out.write(exp.getcmds);
			out.close
			
			val cnf = new BufferedWriter(new FileWriter(d.toString() + "/" + "conf.txt"))
			cnf.write (exp.config.mkString("=", "\n") + "\n" )
			cnf.close
			
			
		}
		outp.close
		
		
		
		
		
	}
	
}