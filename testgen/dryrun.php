<?php

$gitpath = "/build/morty/dryrun.git";

require('gentest.php');

#git_select($conf, "-n1");
cflags_numb($conf, 'ROUTE_CONF_ENTRIES', 2, 18, 2);
cflags_numb($conf, 'ROUTE_CONF_DECAY_THRESHOLD', 2, 20, 8);
cflags_numb($conf, 'ROUTE_CONF_DEFAULT_LIFETIME', 60, 200,  60);
//git_select($conf, "--since=2011-011-01 -- core cpu/msp430 plattform/sky");

git_set($conf, "master");

test_set($conf, "realsim_scan_10min");

var_dump($conf);


traverse($conf, 0, $job);
?>
