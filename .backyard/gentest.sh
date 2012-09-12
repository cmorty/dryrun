#!/bin/bash
source	config.sh
source helper/gentest_functions.sh


# The Git Repository
RGIT="git://contiki.git.sourceforge.net/gitroot/contiki/contiki"

# The Testcases
TESTS=sky_collect_final

# The Git-Revsions. These are parameters passed to git log
GIT_VERSIONS="--since=2007-01-01 -- core cpu/msp430 plattform/sky"

# Commandline Parameters
PARAMETERS=makro_num "" 1 20

echo ${PARAMETERS[@]:0}

export RGIT
