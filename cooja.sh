#!/bin/bash

source config.sh

ATT=
if [ $# -eq 1 ]; then
	ATT="-quickstart=$1"
fi

START="${COOJA} ${ATT}  -external_tools_config=${COOJACONFIG} "

echo Starting: $START
$START

