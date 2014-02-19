package de.fau.dryrun.testgen.source

import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen._
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Set
import org.eclipse.jgit.lib._
import org.eclipse.jgit.storage.file.FileRepositoryBuilder
import java.io.File
import org.eclipse.jgit.storage.file.FileRepository
import scala.collection.JavaConversions._


object Git {
	var git = "git"
}


class Git(gitdir:String)(implicit conf: de.fau.dryrun.testgen.Config) extends Step {
	
	val versions = Set[ObjectId]()

	
	val builder = new FileRepositoryBuilder
	
	val git = org.eclipse.jgit.api.Git.open(new File(gitdir))
	val rep = new FileRepository(gitdir + "/.git")
	val paths = Set[String]()
	
	val contikipath = Set("apps", "core",  "cpu",  "examples",  "platform",  "Makefile.include", 
			"tools/empty-symbols.c",  "tools/empty-symbols.h",  "tools/make-empty-symbols",  
			"Makefile", "scan-neighbors.c")
	
	var outdir = "."

	if(rep.getRepositoryState == RepositoryState.BARE){
		throw new Exception("No Git repo found at " + gitdir)
	}
	
	
	def setVer(vers: String){
		val v = rep.resolve(vers)
		if(v == null) throw new Exception("Not found: " + v )	
		versions += v
		
	}
	
	
	def setRange(from: String, to:String){
		val f = rep.resolve(from)
		if(f == null) throw new Exception("Not found: " + from )			
		
		val t = rep.resolve(from)
		if(t == null) throw new Exception("Not found: " + to )
		val vers = git.log.addRange(f, t).call
		for(v <- vers) versions += v
		
	}
	
	def setRange(from:String, numb:Int){
		val f = rep.resolve(from)
		if(f == null) throw new Exception("Not found: " + from )
		val vers = git.log.add(f).setMaxCount(numb).call
		for(v <- vers) versions += v
	}
	
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		val rv = new ArrayBuffer[Experiment]
		for(exp <- exps) for(v <- versions){
			val cexp = exp.copy
			cexp.addcommand(new Command{
				val ves = v
				def getcmd()(implicit exp: Experiment):String = {
					var rv = "git --gitdir="  + gitdir + "./git archive --format=tar "
					if(paths.size > 0 ){
						rv += (paths.head /: paths.tail)(_ + " " + _) 
					}
					rv += " | ( cd " + exp.chroot + "/" + outdir + " && tar xf -) \n"
					rv
				}
			})	
			
		}
		exps
	}
	
	
	
	
	def setcp(cp:String) {
		GetDir.cp = cp
	}  

}
