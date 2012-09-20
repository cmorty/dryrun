package de.fau.dryrun.testgen.run

import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Map
import scala.collection.mutable.Set
import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen._
import scala.collection.mutable.ListBuffer







private class Flagman {
	
	val flags = Map[String, Set[String]]()
	
	def add(name:String, opt:scala.collection.Set[String]){
		
		if(!flags.contains(name)){
			val s = Set[String]()
			s ++= opt
			flags += name -> s
		} else {	
			flags(name) ++= opt
		}		
	}
	
	def toParset:ArrayBuffer[Parset] = {
		var rv = new ArrayBuffer[Parset]
		rv += new Parset
			
		for((d, v) <- flags){
			val outp = new ArrayBuffer[Parset]
			println("outp" + outp)
			for(dat <- v){
				println("dat " + dat)
				for(par <- rv){
					println("par" + par)
					val cpar = par.copy				 
					cpar.add(d , dat, v.size == 1)					
					outp += cpar
				}
			}
			
			rv = outp
		}
		if(rv.size == 0){
			rv +=  new Parset
		}
		
		rv
	}
	
}


class Make(rundir:String = ".") extends Step {

	private val cflags = new Flagman
	private val confs = new Flagman
	private val flags = new Flagman
	private val targets = ListBuffer[String]()
	
	
	def addFlag(name:String, options:String*){
		val opt = options.toSet
		flags.add(name, opt)
	} 
	
	def addCFlag(name:String, options:String*){
		val opt = options.toSet
		cflags.add(name, opt)
	} 
	
	def addCFlag(name:String, start:Int, stop:Int, step:Int = 1){
		val r = new Range(start, stop + 1, step)
		addCFlag(name, r.toList.map(_.toString):_*)
	}
	
	def addConf(name:String, options:String*){
		val opt = options.toSet
		confs.add(name, opt)
	} 
	
	
	def addConf(name:String, start:Int, stop:Int, step:Int = 1){
		val r = new Range(start, stop + 1, step)
		addConf(name, r.toList.map(_.toString):_*)
	}
	
	
	
	def addTarget(name: String){
		targets += name
	}
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
				
		val cflagsset = cflags.toParset;
		//Convert Confs to CFLAGS
		
				
		val rv = new ArrayBuffer[Experiment]
		for(par:Parset <- flags.toParset;
		    cflag:Parset <- cflags.toParset;
		    conf:Parset <- confs.toParset;
			exp <- exps){		
				val cexp = exp.copy
				
				//CFLAGS
				if(cflag.param.size > 1) cexp.addname("CF§" + cflag.mkString("#",""))
				cexp.addConfig(new Parset(cflag.param.map(s => "CF_" + s._1 -> s._2)))
				
				//CONF
				if(conf.param.size > 1) cexp.addname("D§" + conf.mkString("#","-"))
				cexp.addConfig( new Parset(conf.param.map(s => "C_" + s._1 -> s._2)))
				
				///Parameter
				if(par.param.size > 1) cexp.addname("MAKE§" + par.mkString("#","-"))
				cexp.addConfig( new Parset(par.param.map(s => "MAKE_" + s._1 -> s._2)))
				
				
				
				// Merge conf to CFlags				
				for(f <- cflag.param) cexp.addConfig("CF_" + f._1 , f._2._1, f._2._2)
				
				
				
				
				//Convert from Conf to CFLAG
				val cpar = new Parset(cflag.param ++ conf.param.map(s => "-D" + s._1 -> s._2) )
				
				
				cexp.addcommand(new Command {
					val para = par
					def getcmd()(implicit exp: Experiment):String = {
						var rv = "cd " + exp.chroot + "/" + rundir  +" && "+
								" CFLAGS=\"" + cpar.para + "\" make " + par.para 
								
						if(targets.size > 0){
							rv += targets.mkString(" ") 
						}
						rv += "\n"
						rv
					}
				})
				
				

				rv += cexp
			}
		
		
		rv
		
	}

}