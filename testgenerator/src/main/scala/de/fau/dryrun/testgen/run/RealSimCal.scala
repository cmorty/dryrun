package de.fau.dryrun.testgen.run

import scala.collection.mutable.ArrayBuffer
import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen.Config
import de.fau.dryrun.testgen.Experiment
import de.fau.dryrun.testgen.Command

import scala.xml.XML
import scala.collection.mutable.Set
import scala.collection.mutable.ArrayBuffer

object RealSimCal{
	var path = "$WISEBEDEXP";
	 
}

class RealSimCal(val setfile:String)(implicit val conf:Config) extends Step {
    
	val nodes = Set[String]()
	var time = 5
	var output = "cal.dump"
		
	def addNode(mote:String *){
		nodes ++= mote
	}
	
	
	
	val cpycmd = new Command {
		def getcmd()(implicit exp: Experiment):String = {
			val xmld = 
<expconf>
	<time>{time.toString}</time> 	
	{ nodes.map(x => <mote>{x}</mote>)}
	<output>'{output}'</output>
</expconf>	
			val expfile = exp.datapath + "/calib.xml" 
			XML.save(expfile , xmld)
						
			"cd " + exp.chroot + " && " + RealSimCal.path + " " + expfile  + " " +  setfile  + "\n" +
			"mkdir -p " + exp.datapath + "/" + conf.resultpath + "\n" +
			"cp" + " " + exp.chroot + "/" + output + " " + exp.datapath + "/" + conf.resultpath + "\n"
		}
	}
	
	
	def registerExperiment(exps:ArrayBuffer[Experiment]):ArrayBuffer[Experiment] = {
		for(exp <- exps) exp.addcommand(cpycmd) 
		exps
	}
	
	
	
}