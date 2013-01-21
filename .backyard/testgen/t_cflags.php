<?php


class t_cflags {

	function &getref(&$conf, $name){
		//Check wheter there is already a setting
		$rv = NULL;
		foreach($conf as &$confe){
			if($confe['type'] != 'cflags') continue;
			if($confe['name'] != $name) continue;
			$rv = &$confe['opt'];
		}
		if($rv === NULL){
			$rv = array('type' => 'cflags', 'pos'=> 0, 'name' => $name, 'opt' => array());
			$conf[] = $rv;
			$rv = &$conf[count($conf) - 1]['opt'];
		}
		return $rv;
	
	}
	
	
	function numb(&$conf, $name, $args){
		if(count($args)<3 || count($args) > 4){
			return "Wrong number of arguments";
		}
		$start = $args[0];
		$end = $args[1];
		$step = isset($args[2]) ?  $args[2] : 1;
		
		
		$ref =  &$this->cflags_getref(&$conf, $name);
	
		//var_dump($ref);
	
		for ($i = $start; $i <= $end; $i += $step ) {
			if(!in_array($i, $ref)) $ref[] = $i;
		}
		return true;
	}

	
	function para(&$conf, $args){
		if(count($args) != 2) return "Need key and value";
		
		$ref = &$this->getref(&$conf, $args[0]);
		$flags = func_get_args();
	
		array_shift($args);
		array_shift($args);
	
		$ref += array_diff($args, $ref);
		return true;
	}
	
	
	public function help(){
		return array("set, <key>, <value>\n",
				"numb, <key>, <start>, <end>[, <step> = 1]");
	}
	
	
	
	function set(&$conf, $cmd, $args){
		if($cmd == "set"){
			return $this->para(&$conf, $args);
			
		}
		
		if($cmd == "para"){
			return $this->numb(&$conf, $args);
			
		}
		return "Command not supported";
	}
	
	
	

	
	
	public function job(&$set, &$job){
		if(!isset($job['CFLAGS'])){
			$job['CFLAGS'] = '';
		}
		$val = $set['opt'][$set['pos']];
		$job['FILENAME'] .= "${set['name']}_${val}";
		$job['CFLAGS']   .= "-D${set['name']}=${val} ";
		$set['pos']++;
	
		if($set['pos'] == count($set['opt'])){
			$set['pos'] = 0;
			return true;
		}
		return false;
	}
}

?>