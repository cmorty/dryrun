<?

$outdb = "/tmp/morty/all.sqlite";
$jobpath = "jobs";
$debug = false;


$params = array("ROUTE_CONF_ENTRIES", "ROUTE_CONF_DECAY_THRESHOLD", "ROUTE_CONF_DEFAULT_LIFETIME" );

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


/***********************************************************************/

function opendb($dbname){
	

	return $db;
}

function dexec($query){
	global $debug, $db;
	if($debug) echo $query . "\n";
	try{
		$res = $db->exec($query);
	}catch(PDOException $e){
		die($e->getMessage()." line: ".$e->getLine()."\n");
	}
}


function dquery($query){
	global $debug, $db;
	if($debug) echo $query . "\n";
	try{
		$res = $db->query($query);
	}catch(PDOException $e){
		die($e->getMessage()." line: ".$e->getLine()."\n");
	
	}

	return $res;
}



// Create DB
if(file_exists($outdb)) unlink($outdb);
$db = new PDO("sqlite:".$outdb);

$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//Turn of journal

dexec("PRAGMA journal_mode =  OFF; ");
dexec("PRAGMA synchronous = OFF;");

$query = "CREATE TABLE data( " . implode(" INTEGER, ", $params) . " INTEGER," .
		"VAR TEXT, " .
		"Mote INTEGER, " .
		"Time INTEGER, " .
		"Data NUMERIC);";

dexec($query);

dexec('CREATE INDEX DATASET ON data ('. implode(", ", $params) .', VAR);');

$folders = scandir($jobpath);

$pos = 0;
//var_dump($folders);
$time_start = microtime(true);
foreach($folders as $folder){
	$curd = $jobpath . '/' . $folder;
	$pos ++;

	//if($pos == 10) break;
	
	if($pos % 10 == 0){

		$runtime = microtime(true) - $time_start;

		printf( "\r %4d / %4d : %.3d%% - %3ds of %3ds",$pos, count($folders), floor($pos / count($folders) * 100), floor($runtime), floor($runtime / $pos * count($folders)));
		
	}

	if(! is_dir($curd)){

		continue;
	}


	$bq = 'INSERT INTO DATA SELECT ';
	if($debug) echo "\n\n";
	if($debug) echo "$folder \n";
	$pars = explode("#", $folder);
	//var_dump($pars);

	if(count($pars) != count($params) + 2  ){
		echo "\nIgnoring ${folder}\n";
		continue;
	}
	for($i= 0; $i < count($params); $i++){
		//var_dump($pars[$i]);
		$d = explode("_", $pars[$i]);
		$bq .= array_pop($d) . ", ";
	}

	$bq .= "var, replace(mote, 'Sky ', '' ), time, data FROM variables;";


	$files = scandir($curd);
	foreach($files as $file){
		$ff = explode(".", $file);
		if(strcmp("db", array_pop($ff))){
			continue;
		}
		dexec("ATTACH DATABASE '".$curd. '/' .$file."' AS import;");
		dexec($bq);
		dexec("DETACH DATABASE import;");
	}

}

echo "\nDatabase: " . $outdb . "\n";






?>

