<?php
class t_sim{

	function &getref(&$conf){
		//Check wheter there is already a setting
		$rv = NULL;
		foreach($conf as &$confe){
			if($confe['type'] != 'test') continue;
			$rv = &$confe['tests'];
		}
		if($rv === NULL){
			$rv = array('type' => 'test', 'pos'=> 0, 'tests' => array());
			$conf[] = $rv;
			$rv = &$conf[count($conf) - 1]['tests'];
		}
		return $rv;
	
	}
	
	public function help(){
		return array("set, <name of sim>, <name of sim>, ....");
	}
	
	
	public function set(&$conf, $cmd, $args){
		$ref = &getref($conf);
		if($cmd != "set"){
			return false;
		}
		$ref = array_merge($ref, array_diff($args, $ref));
		return true;
	}
	
	
	
	public function job(&$set, &$job){
		if(!isset($job['TEST'])){
			$job['TEST'] = '';
		}
		$val = $set['tests'][$set['pos']];
		$job['FILENAME'] .= $val;
		$job['TEST']   = trim($val);
		$set['pos']++;
	
		if($set['pos'] == count($set['tests'])){
			$set['pos'] = 0;
			return true;
		}
		return false;
	}
}