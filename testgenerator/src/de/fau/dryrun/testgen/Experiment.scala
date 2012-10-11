package de.fau.dryrun.testgen

import scala.collection.mutable.ArrayBuffer
import java.security.MessageDigest

object Experiment{
	val init = new Command{
		def getcmd()(implicit exp: Experiment):String = {
		
			
			{
				if(exp.clean) {
					"rm -rf \"" + exp.chroot + "\"\n"
				} else {
					""
				} 
			} + "mkdir -p \"" + exp.chroot + "\"\n"
			
		}
	}
		
}



class Experiment(var name:String = "", val cmds:ArrayBuffer[Command] = new ArrayBuffer[Command], val config:Parset = new Parset)(implicit conf: Config) {
	
	if(cmds.size == 0) cmds += Experiment.init
	
	
	def clean = conf.clean
	
	
	def sanitize(path:String):String = {
		path.replace("\"", "").replace("=","")
	}
	
	def addConfig(name:String, value:String, unique: Boolean){
		config.add(name, value, unique)
	}
	
	def addConfig(ps:Parset){
		config.add(ps)
	}
	
	
	def chroot = conf.workdir + "/" +  hash
	
	def datapath = conf.outdir +"/"+  hash
	
	def namepath =  sanitize(conf.namepath +"/"+  name)
	
	def hash:String = {
		val md = MessageDigest.getInstance("SHA-1");
		val ba = config.mkString("=", "\n").getBytes()
		val hash = md.digest(ba).map("%02X" format _)
		hash.mkString
	}
	
	
	def addname(name:String){
		if(name.equals("")) return
		if(this.name.length > 1) this.name += "_"
		this.name += name.replace(" ", "-") 
	}
	
	def addcommand(cmd: Command){
		cmds += cmd
	}

	def getcmds:String = {
		implicit val exp = this
		var rv = ""
		for(cmd <- cmds){
			rv += cmd.getcmd
		}
		
		rv
	}
	
	def copy:Experiment = new Experiment(name, cmds.clone, config.copy)		
}