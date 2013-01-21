<?php
class t_git{
	

	function &getref(&$conf){
		//Check wheter there is already a setting
		$rv = NULL;
		foreach($conf as &$confe){
			if($confe['type'] != 'git') continue;
			$rv = &$confe['revs'];
		}
		if($rv === NULL){
			$rv = array('type' => 'git', 'pos'=> 0, 'revs' => array());
			$conf[] = $rv;
			$rv = &$conf[count($conf) - 1]['revs'];
		}
		return $rv;

	}

	function select(&$conf, $string){
		global $gitpath;
		//Check wheter there is already a setting
		$ref = &git_getref($conf);
		$revs = shell_exec("git --git-dir=$gitpath/.git log --pretty=format:%h $string");
		$revs = explode( "\n", $revs);
		$ref = array_merge($ref, array_diff($revs, $ref));
	}

	
	
	public function help(){
		return array("set, <rev1>, <rev2>, ....");
	}
	
	
	function set(&$conf, $cmd, $args){
		$ref = &getref($conf);
		if($cmd != "set"){
			return false;
		}
		foreach($revs as $rev){
			$this->select(&$conf, $rev . " -n1");
		}
		return true;
	}



	function job(&$set, &$job){
		if(!isset($job['GITREV'])){
			$job['GITREV'] = '';
		}
		$val = $set['revs'][$set['pos']];
		$job['FILENAME'] .= "${val}";
		$job['GITREV']   = "${val} ";
		$set['pos']++;

		if($set['pos'] == count($set['revs'])){
			$set['pos'] = 0;
			return true;
		}
		return false;
	}
}
?>