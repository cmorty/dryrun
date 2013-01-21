<?php

require_once('t_cflags.php');
require_once('t_git.php');
require_once('t_sim.php');

class testgen {
	/*************************************** GENERAL ****************************************************/
	
	
	private $jpath;
	private $debug;
	private $conf = array();
	private $job = array('FILENAME' => '');
	private $jobpath;
	
	
	private $t;
	
	
	function getconf(){
		return $conf;
	}
	
	function __construct($jobpath= "./jobs", $debug = false) {
		
	
		if(!is_dir($jobpath)){
			if(mkdir($jobpath) == false){
				echo "ERROR: Could not create \$jobpath: $jobpath \n";
				exit(1);
			}
		}
		$this->jobpath = $jobpath;
		$this->debug = $debug;
		
		
		$this->t["cflags"] = new t_cflags();
		$this->t["git"] = new t_git();
		$this->t["sim"] = new t_sim();
		
		
	/*
		if(!isset($gitpath)){
			$gitpath = "../gitdir";
		}
		
		if(!is_dir($gitpath)){
			echo "ERROR: Could not find \$gitdir: $gitdir \n";
			exit(1);
		}*/
		
	}
	
	
	

	
	function writeJob($job){
		if($this->debug){
			echo "\n======  ${job['FILENAME']}  ============ \n";
		}else {
			$fp = fopen($this->jobpath . '/' . $job['FILENAME'] . '.job', 'w');
		}
		foreach($job as $key => $value){
			if($debug){
				echo "${key}=${value}\n";
			} else {
				fwrite($fp, "${key}=${value}\n");
			}
		}
		if(!$this->debug){
			fclose($fp);
		}
	}
	
	public function set($t, $cmd){
		$args = func_get_args();
		array_shift($args);
		array_shift($args);
			
	}
	
	public function genhelp(){
		$rv = "";
		foreach($this AS $key=>$val){
			$rv .= "$key:";
			$rv .= implode("\n\t", $val->help());
			$rv .= "\n\n";
		}
	}
	
	
	public function run(){
		tracverse($this->conf, 0, $this->job);
	}
	
	function traverse($conf, $pos, $job){
		test_ok();
		$plevel = &$conf[$pos];	
		$done = false;
		while(!$done){
			$job_cur =  $job;
			
			$done = $this->t[$plevel["type"]].job( &$conf[$pos], &$job_cur);
	
			if($pos < count($conf) - 1 ){
				$job_cur['FILENAME'] .= ($job_cur['FILENAME'] != '' )? '#' : '';
				traverse($conf, $pos+1, $job_cur);
			} else {
				writejob($job_cur);
			}
		}
	
	}
	
	



}

$test = new testgen();

function set($t, $cmd){
	global $test;
	$args = func_get_args();
	$rv = call_user_func_array($test->set, func_get_args());
	if($rv !== true){
		echo "Setting (\"" . explode("\", \"") . "\") failed with error: $rv\n\n";
		echo $test->genhelp();
		exit(1);
	}
}

function run(){
	global $test;
	$test->run();
}

require $argv[1];



?>



