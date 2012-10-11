package de.fau.dryrun.testgen


import scala.collection.mutable.ArrayBuffer
import java.io.BufferedWriter
import java.io.FileWriter
import java.io.File
import scala.collection.mutable.StringBuilder
import scala.actors.Futures._
import scala.actors.Future



class Config {
	
	
	var resultpath = "results"
	var namepath = "nm"	
		
	var outdir = "/tmp/dryrun/tests"
	var workdir = "/tmp/dryrun/work" 
    
	var  clean = true
		
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
		
		val fAll =  new File(outdir + "/all.jobs")
		val fNew =  new File(outdir + "/new.jobs")
		val fLinks =  new File(outdir + "/lnks.sh")
		new File(outdir).mkdirs();
			
		val wAll  = new BufferedWriter(new FileWriter(fAll))
		val wNew  = new BufferedWriter(new FileWriter(fNew))
		val wLinks  = new BufferedWriter(new FileWriter(fLinks))
		//io.Source.fromFile("data.txt").mkString
		
		
		
		for(exp <- exps){
			val sb = new StringBuilder
			val d = new File(exp.datapath)
			d.mkdirs
			val of = new File(d.toString() + "/" + "exp.sh")
			val cf = new File(d.toString() + "/" + "conf.txt")
					
			//printf("--- " +exp.name+" ---\n%s-------\n" , exp.getcmds)
			
			val cmds= exp.getcmds
			val cnfs= exp.config.mkString("=", "\n") + "\n" 
			
			if(!of.exists || !cf.exists || !io.Source.fromFile(of).mkString.equals(cmds) || !io.Source.fromFile(cf).mkString.equals(cnfs) ){
				//Write out commands
				val out = new BufferedWriter( new FileWriter(of))
				
				out.write(cmds)
				future{out.close}
				
				
				of.setExecutable(true)				
				
				val cnf = new BufferedWriter(new FileWriter(cf))
				cnf.write (cnfs)
				future{cnf.close}
				
				
				
					
					
			}
			
			//If no results exist add to new
			if(! new File(d, resultpath).exists()){
				wNew.write("\"" + of.toString() + "\" 1>\"" + d.toString() + "/" + "exp.log\" 2>&1\n" )
			}
			
			wLinks.write( "ln -s " + d.toString() + " " + exp.namepath );
			
			wAll.write("\"" + of.toString() + "\" 1>\"" + d.toString() + "/" + "exp.log\" 2>&1\n" )
			
			
		}
		wNew.close
		wAll.close
		wLinks.close
		fLinks.setExecutable(true)

		
		
		
		
		
		
		
		
	}
	
}
