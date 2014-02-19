package de.fau.dryrun.testgen
import scala.collection.mutable.Map

class Parset (val param: Map[String,(String, Boolean, Boolean)] = Map[String, (String, Boolean, Boolean)]()){ 
	
	def copy:Parset = new Parset(param.clone)
	
	/**
	 * @param k        Key
	 * @param v		   Value
	 * @param unique   Is there more then one value for this key
	 * @param random   Is this a parameter that adds randomness to the experiment, but does not influence the source paramters
	 */
	def add(k:String, v:String, unique:Boolean, random: Boolean){
		param += k -> (v, unique, random)
	}
	
	def add(ps:Parset){
		param++= ps.param
	}
	
	
	/**
	 * @param ass The assignment: key + ass + value
	 * @param div The divsor key-val-ass + div + key-val-ass
	 * @param all Use all or only non-unique keys
	 * @return
	 */
	def mkString(ass:String, div:String, all:Boolean = false):String={
		//Do not add unique Attibutes to the name
		param.filter(!_._2._2 || all).map(e => e._1 + ass + e._2._1).mkString(div)
	}
	
	
	
	def para():String = mkString("=", " ", true)
	def name:String = mkString("#", "-")
	
	def nonRandom():String =
		param.filter(!_._2._3).map(e => e._1 + "=" + e._2._1).mkString(" ")
	
	
}