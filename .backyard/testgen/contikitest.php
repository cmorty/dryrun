<?php



require(gentest.php);

#git_select($conf, "-n1");
cflags_numb($conf, 'COLLECT_NEIGHBOR_CONF_MAX_COLLECT_NEIGHBORS', 1, 30, 1);
#cflags_numb($conf, 'ROUTE_CONF_ENTRIES', 1, 30, 2);
#cflags_numb($conf, 'DECAY_THRESHOLD', 2, 20,2);
#cflags_numb($conf, 'DECAY_ROUTE_CONF_DEFAULT_LIFETIME', 30, 300,  30);
//git_select($conf, "--since=2011-011-01 -- core cpu/msp430 plattform/sky");

git_set($conf, "origin/master");

test_set($conf, "sky_collect_trace_100_bad_db");

var_dump($test->getconf());


traverse($conf, 0, $job);
?>
