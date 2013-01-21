<?php
//Test parameters


require_once 'testgen.php';

if(!isset($argv[1])){
	echo "Config file not set\n";
	exit(2);
}

if(!is_file($argv[1])){
	echo "File ${argv[1]} not found\n";
}

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



?>