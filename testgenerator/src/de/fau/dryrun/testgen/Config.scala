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
import scala.util.Random



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
		//This implementation sucks, but I'm to lazy to fix it.
		val randmap = HashMap[String, Stack[String]]()
		val randmapNew = HashMap[String, Stack[String]]()
		var exps = ArrayBuffer[Experiment]()
		exps += new Experiment
		
		for(step <- steps){
			println("registering step: " + step)
			exps = step.registerExperiment(exps)
			println("Number of experiments: " + exps.size )			
		}
		
		Experiment.count = exps.size 
		
		val allcmds = collection.mutable.Buffer[String]()
		val newcmds = collection.mutable.Buffer[String]()
	    
		
		new File(outdir).mkdirs();
		val fLinks =  new File(outdir + "/lnks.sh")
		val wLinks  = new BufferedWriter(new FileWriter(fLinks))
		
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
			
			val cmdstr = "\"" + of.toString() + "\" 1>\"" + d.toString() + "/" + "exp.log\" 2>&1"
			
			
			allcmds += cmdstr
			if(! new File(d, resultpath).exists()){
				newcmds += cmdstr
			}
			
			wLinks.write( "ln -s " + d.toString() + " " + exp.namepath + "\n");
			

		}
		
		
		wLinks.close
		
		
		val fAll =  new File(outdir + "/all.jobs")
		val fNew =  new File(outdir + "/new.jobs")
		val fRand =  new File(outdir + "/rand.jobs")
		val fRandNew =  new File(outdir + "/randnew.jobs")
		
		
		
			
		val wAll  = new BufferedWriter(new FileWriter(fAll))
		val wNew  = new BufferedWriter(new FileWriter(fNew))
		val wRand  = new BufferedWriter(new FileWriter(fRand))
		val wRandNew  = new BufferedWriter(new FileWriter(fRandNew))
		
		List(fLinks, fNew,fAll,fRand,fRandNew).foreach(_.setExecutable(true))
		
		
		//io.Source.fromFile("data.txt").mkString
		
		wAll.write(allcmds.mkString("\n")+ "\n")
		wNew.write(newcmds.mkString("\n")+ "\n")
		
		val r = new Random
			
		wRand.write(r.shuffle(allcmds).mkString("\n")+ "\n")
		wRandNew.write(r.shuffle(newcmds).mkString("\n")+ "\n")
		
		wNew.close
		wAll.close

		wRand.close
		wRandNew.close
		
		
		
	}
	
}
