package de.fau.dryrun.testgen.source

import scala.collection.TraversableOnce.flattenTraversableOnce
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Buffer

import de.fau.dryrun.testgen.Command
import de.fau.dryrun.testgen.Experiment
import de.fau.dryrun.testgen.Step
import de.fau.dryrun.testgen.run.Cooja

object RealSimMapType extends Enumeration {
	type RealSimMapType = Value

	/**
	 * Map offsets round robin
	 */
	val MapRR = Value //Map offsets round robin as they come
	val MapSeed = Value //Always map the same offset on the same seed
	val MapSeedDist = Value //Distribute the seeds over the rand (setStartStop must be set)
}

object RealSim {
	var rs2rs = "java -jar rs2rs.jar"
}

class RealSim(input: String, output: String)(implicit conf: de.fau.dryrun.testgen.Config) extends Step {
	

	import RealSimMapType._

	var length = 20 //In minutes
	var mapping = MapRR
	
	private val offsets = Buffer[Int]()
	private var seedMap = collection.mutable.Map[Int, Int]()
	
	private var start = 0;
	private var stop = 0;
	
	/**
	 * Add an offset
	 */
	def addOffset(offset: Int*) {
		offsets ++= offset
	}

	/**
	 * Add a range of offsets
	 */
	def addOffRange(start: Int, stop: Int, step: Int = 600) {
		val r = Range.Int(start, stop + 1, step)
		addOffset(r.toList: _*)
	}
	
	def setStartStop(start:Int, stop:Int) {
		this.start = start
		this.stop = stop
	}
	

	lazy val rrIT = Iterator.continually(offsets).flatten

	private val mapRRCmd = new Command {
		var start_offset = -1
		
		def getcmd()(implicit exp: Experiment): String = {
			val mult = 60 * 1000
			RealSim.rs2rs + " " + input + " " + exp.chroot + "/" + output + " " + start_offset * mult + " " + length * mult + "\n"
		}
		
		override
		def finish()(implicit exp: Experiment){
			start_offset = mapping match {
				case MapRR => rrIT.next
				case MapSeed =>
					val seed = exp.config.param("seed")._1.toInt
					seedMap.getOrElseUpdate(seed, rrIT.next)
				case MapSeedDist =>
					if(offsets.length == 0) {
						val cooja = conf.steps.find(_.isInstanceOf[Cooja]).get.asInstanceOf[Cooja]
						val num = cooja.random.length
						val time = stop -start
						var step = time / num 
						if(step > length) {
							println("Rset: start: " + start + " stop: " + stop + " step " + step)
							addOffRange(start, stop, step)
						} else {
							step = (time - length) / (num -1 )
							println("Rset2: start: " + start + " stop: " + stop + " step " + step)
							addOffRange(start, stop-length + 1, step)
						}
					}
					val seed = exp.config.param("seed")._1.toInt
					println("seed:                              " + seed)					
					seedMap.getOrElseUpdate(seed, rrIT.next)
			}
			exp.addConfig("rsoffset",start_offset.toString, offsets.length == 1, false)
		}
		
	}

	def registerExperiment(exps: ArrayBuffer[Experiment]): ArrayBuffer[Experiment] = {

		mapping match {
			case _ =>
				exps.foreach(_.addcommand(mapRRCmd))
				exps

		}
	}

}
