<?php

$jobpath = "jobs";
$gitpath = "gitdir";
$debug = false;


error_reporting(-1);


function ecb($errno, $errstr, $errfile, $errline)
{
    if (!(error_reporting() & $errno)) {
        echo "Unknown error: ${errno}\n";
		exit(1);
    }

    switch ($errno) {
		case E_USER_ERROR:
		    echo "ERROR: [$errno] $errstr: $errfile($errline)\n";
		    exit(1);
		    break;

		case E_USER_WARNING:
		    echo "Warning: [$errno] $errstr: $errfile($errline)\n";
		    break;

		case E_USER_NOTICE:
		    "Notice: [$errno] $errstr: $errfile($errline)\n";
		    break;

		default:
		    echo "ERROR: [$errno] $errstr: $errfile($errline)\n";
		    exit(1);
    }

    /* Don't execute PHP internal error handler */
    return true;
}


set_error_handler('ecb');



/*************************************** CFLAGS ****************************************************/


function &cflags_getref(&$conf, $name){
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


function cflags_numb(&$conf, $name, $start, $end, $step=1){
	$ref = &cflags_getref(&$conf, $name);

	var_dump($ref);
	
	for ($i = $start; $i <= $end; $i += $step ) {
		if(!in_array($i, $ref)) $ref[] = $i;
	}
}


function cflags_para(&$conf, $name){
	$ref = &cflags_getref(&$conf, $name);
	$flags = func_get_args();

	array_shift($flags);
	array_shift($flags);
	
	$ref += array_diff($flags, $ref);
}



function cflags_job(&$set, &$job){
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


/*************************************** GIT      ****************************************************/


function &git_getref(&$conf){
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

function git_select(&$conf, $string){
	global $gitpath;
	//Check wheter there is already a setting
	$ref = &git_getref($conf);
	$revs = shell_exec("git --git-dir=$gitpath/.git log --pretty=format:%h $string");
	$revs = explode( "\n", $revs);
	$ref = array_merge($ref, array_diff($revs, $ref));
}


function git_set(&$conf){
	$revs = func_get_args();
	array_shift($revs);
	foreach($revs as $rev){
		git_select(&$conf, $rev . " -n1");
	}
}



function git_job(&$set, &$job){
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

/*************************************** TESTS    ****************************************************/


function &test_getref(&$conf){
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


function test_set(&$conf){
	$ref = &test_getref($conf);
	$tests = func_get_args();
	array_shift($tests);
	$ref = array_merge($ref, array_diff($tests, $ref));
}



function test_job(&$set, &$job){
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




/*************************************** RUN      ****************************************************/

function writeJob($job){
	global $debug, $jobpath;
	if($debug){
		echo "\n======  ${job['FILENAME']}  ============ \n";
	}else {
		$fp = fopen($jobpath . '/' . $job['FILENAME'] . '.job', 'w');
	}
	foreach($job as $key => $value){
		if($debug){
			echo "${key}=${value}\n";
		} else {
			fwrite($fp, "${key}=${value}\n");
		}
	}
	if(!$debug){
		fclose($fp);
	}
}


function traverse($conf, $pos, $job){
	$plevel = &$conf[$pos];	
	$done = false;
	while(!$done){
		$job_cur =  $job;
		
		$done = call_user_func($plevel["type"] . '_job', &$conf[$pos], &$job_cur);

		if($pos < count($conf) - 1 ){
			$job_cur['FILENAME'] .= ($job_cur['FILENAME'] != '' )? '#' : '';
			traverse($conf, $pos+1, $job_cur);
		} else {
			writejob($job_cur);
		}
	}

}

$conf = array();
$job = array('FILENAME' => '');

#git_select($conf, "-n1");
cflags_numb($conf, 'COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS', 1, 30, 1);
#cflags_numb($conf, 'ROUTE_CONF_ENTRIES', 1, 30, 2);
#cflags_numb($conf, 'DECAY_THRESHOLD', 2, 20,2);
#cflags_numb($conf, 'DECAY_ROUTE_CONF_DEFAULT_LIFETIME', 30, 300,  30);
//git_select($conf, "--since=2011-011-01 -- core cpu/msp430 plattform/sky");

git_set($conf, "origin/master");

test_set($conf, "sky_collect_trace_100_bad_db");

var_dump($conf);


traverse($conf, 0, $job);



?>



