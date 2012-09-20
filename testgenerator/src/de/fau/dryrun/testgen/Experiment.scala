package de.fau.dryrun.testgen

import scala.collection.mutable.ArrayBuffer

object Experiment{
	val init = new Command{
		def getcmd()(implicit exp: Experiment):String = "mkdir -p \"" + exp.chroot + "\"\n"
	}
		
}




class Experiment(var name:String = "", val cmds:ArrayBuffer[Command] = new ArrayBuffer[Command], val config:Parset = new Parset)(implicit conf: Config) {
	
	if(cmds.size == 0) cmds += Experiment.init
	
	
	
	
	
	def snaitize(path:String):String = {
		path.replace("\"", "").replace("=","")
	}
	
	def addConfig(name:String, value:String, unique: Boolean){
		config.add(name, value, unique)
	}
	
	def addConfig(ps:Parset){
		config.add(ps)
	}
	
	
	def chroot = snaitize(conf.workdir + "/" +  name)
	
	def datapath = snaitize(conf.outdir +"/"+ name)
	
	
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