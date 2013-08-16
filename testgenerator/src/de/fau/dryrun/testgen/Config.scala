package de.fau.dryrun.testgen


import scala.collection.mutable.ArrayBuffer
import java.io.BufferedWriter
import java.io.FileWriter
import java.io.File
import scala.collection.mutable.StringBuilder
import scala.actors.Futures._
import scala.actors.Future
import scala.collection.mutable.HashMap
import scala.collection.mutable.Stack



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
	
		val randmap = HashMap[String, Stack[String]]()
		var exps = ArrayBuffer[Experiment]()
		exps += new Experiment
		
		for(step <- steps){
			println("registering step: " + step)
			exps = step.registerExperiment(exps)
			println("Number of experiments: " + exps.size )			
		}
		
		Experiment.count = exps.size 
		
		val fAll =  new File(outdir + "/all.jobs")
		val fNew =  new File(outdir + "/new.jobs")
		val fRand =  new File(outdir + "/rand.jobs")
		val fLinks =  new File(outdir + "/lnks.sh")
		
		new File(outdir).mkdirs();
			
		val wAll  = new BufferedWriter(new FileWriter(fAll))
		val wNew  = new BufferedWriter(new FileWriter(fNew))
		val wRand  = new BufferedWriter(new FileWriter(fRand))
		val wLinks  = new BufferedWriter(new FileWriter(fLinks))
		
		//io.Source.fromFile("data.txt").mkString
		
		
	    
		for(ind <- 0 to (exps.length - 1)){
			val exp =  exps(ind)
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
			
			val cmdstr = "\"" + of.toString() + "\" 1>\"" + d.toString() + "/" + "exp.log\" 2>&1\n"
			
			
			wAll.write(cmdstr)
			if(! new File(d, resultpath).exists()){
				wNew.write(cmdstr)
			}
			
			wLinks.write( "ln -s " + d.toString() + " " + exp.namepath );
			
			//Add Command to randmap
			val randkey = exp.config.nonRandom
			randmap.getOrElseUpdate(randkey, Stack[String]()) push cmdstr
			
			
			
			
		}
		wNew.close
		wAll.close
		wLinks.close
		fLinks.setExecutable(true)

		while(randmap.size > 0){
			for(rmapel <- randmap){
				wRand.write(rmapel._2.pop)
				//If there are no more commands remove element.
				if(rmapel._2.size == 0){
					randmap -= rmapel._1
				}
			}
		}
		wRand.close
		
		
		
		
		
		
	}
	
}
