<?

$outdb = "results.sqlite";
$resultpath = "results";
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

/******************** HELPER ************************/
function endsWith( $str, $sub ) {
   return ( substr( $str, strlen( $str ) - strlen( $sub ) ) === $sub );
}

function getConf($folder){
	$rv = array();
	$cdata = file($folder . '/conf.txt');
	foreach($cdata as $dat){
		if(strlen($dat) < 2) continue
		var_dump(explode("=", $dat));
		list($key, $val) = explode("=", $dat);
		$rv[trim($key)] = trim($val);
	}
	return $rv;
}
/***********************************************************************/

function opendb($dbname){
	return $db;
}

function dexec($query){
	global $debug, $db;
	if($debug) echo "SQL-E: " .  $query . "\n";
	try{
		$res = $db->exec($query);
	}catch(PDOException $e){
		die($e->getMessage()." line: ".$e->getLine()." SQL: $query\n");
	}
}


function dquery($query){
	global $debug, $db;
	if($debug) echo "SQL-Q: " .  $query . "\n";
	try{
		$res = $db->query($query);
	}catch(PDOException $e){
		die($e->getMessage()." line: ".$e->getLine()." SQL: $query\n");
	
	}

	return $res;
}


//Find subfolders
$folders = scandir(".");



//var_dump($folders);
//Walk through folders to find Configuration issues
$keys = array();
$dbs = array();
$error = false;
$badfolders = array();
foreach($folders as $folder){
	$cfolder = $folder . '/' . $resultpath;
	if($folder[0] == '.') continue;
	if(!is_dir($folder)) continue;
	if(!file_exists("$folder/conf.txt")){
		echo "Warning: No conf.txt in $folder\n";
		$badfolders[] = $folder;
		continue;
	}
	if(!is_dir($cfolder)){
		echo "WARNING: No results in $cfolder\n";
		$badfolders[] = $folder;
		continue;
	}


	$lkeys = array();
	$ldbs = array();

	$lkeys = array_keys(getConf($folder));

	foreach(scandir($cfolder) as $dbname){
		if(!endsWith($dbname, ".db")) continue;
		$dbname = strstr($dbname, '.', true);
		$ldbs[] = $dbname;
	}

	if(count($keys) == 0){
		echo "Reference directory: $folder\n";
		$dbs = $ldbs;
		$keys= $lkeys;
		
	} else {
		if(count(array_diff($keys, $lkeys)) != 0){
			echo "WARNING: Keys in $folder do not match\n";
			echo "Reference: " . explode($keys , ", ") . "\n";
			echo "Found:     " . explode($lkeys, ", ") . "\n";
			$error = true;
		}
		if(count(array_diff($dbs, $ldbs)) != 0){
			echo "WARNING: DBs in $folder do not match\n";
			echo "Reference: " . explode($dbs , ", ") . "\n";
			echo "Found:     " . explode($ldbs, ", ") . "\n";
			$error = true;
		}
	}
}

$folders = array_diff($folders, $badfolders);

if($error){
	echo "Sopping because auf errors\n";
	var_dump($dbs);
	var_dump($keys);
	exit(2);
}


// Create DB

if(file_exists($outdb)) unlink($outdb);
$db = new PDO("sqlite:".$outdb);

$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//Turn of journal
dexec("PRAGMA journal_mode =  OFF; ");
dexec("PRAGMA synchronous = OFF;");

dexec("CREATE TABLE DRYRUN (key TEXT, value TEXT);");
foreach($keys as $key){
	dexec("INSERT INTO DRYRUN (key, value) VALUES ('conf','$key');");
}

//Create a table for each Database
foreach($dbs as $dbt){
	$query = "CREATE TABLE $dbt( " . implode(" INTEGER, ", $keys) . " INTEGER," .
		"VAR TEXT, " .
		"Mote INTEGER, " .
		"Time INTEGER, " .
		"Data NUMERIC);";

	dexec($query);

	dexec("CREATE INDEX DATASET_$dbt ON $dbt (" . implode(", ", $keys) .', VAR);');
}

$pos = 0;
$time_start = microtime(true);
foreach($folders as $folder){
	$curd =  $folder . '/' . $resultpath;
	$pos ++;

	//if($pos == 10) break;
	
	if($pos % 10 == 0){

		$runtime = microtime(true) - $time_start;

		printf( "\r %4d / %4d : %.3d%% - %3ds of %3ds",$pos, count($folders), floor($pos / count($folders) * 100), 
		floor($runtime), floor($runtime / $pos * count($folders)));
		
	}
	if(! is_dir($curd)){
		continue;
	}




	if($debug) echo "\n\n";
	if($debug) echo "$folder \n";
	

	//Prepare statement
	$bq = 'SELECT ';
	$conf = getConf($folder);

	if(count($keys) != count($conf)){
		echo "\nIgnoring ${folder} - There's something wrong\n";
		continue;
	}

	foreach($keys as $key){
		$bq .= $conf[$key] . ", ";
	}

	$bq .= "var, replace(mote, 'Sky ', '' ), time, data FROM variables;";



	foreach($dbs as $dbname){				
			dexec("ATTACH DATABASE '". $curd .  '/' .$dbname.".db' AS import;");
			$tbls = dquery("SELECT COUNT(*) FROM import.SQLITE_MASTER;")->fetch();

			if($tbls[0] == 0){
				echo "\nNo Table in $curd/$dbname.db - Skipping\n";
			} else {
				dexec("INSERT INTO " . $dbname .  " " . $bq);
			}
			dexec("DETACH DATABASE import;");
	}

}



echo "\nDatabase: " . $outdb . "\n";






?>

