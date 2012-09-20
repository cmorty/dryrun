package de.fau.dryrun.testgen
import scala.collection.mutable.Map

class Parset (val param: Map[String,(String, Boolean)] = Map[String, (String, Boolean)]()){ 
	
	def copy:Parset = new Parset(param.clone)
	
	def add(k:String, v:String, unique:Boolean){
		param += k -> (v, unique)
	}
	
	def add(ps : Parset){
		param++= ps.param
	}
	
	
	def mkString(ass:String, div:String, all:Boolean = false):String={
		param.filter(!_._2._2 || all).map(e => e._1 + ass + e._2._1).mkString(div)
	}
	
	def para:String = mkString("=", " ", true)
	
	
	def name:String = mkString("#", "-")
	
	
}