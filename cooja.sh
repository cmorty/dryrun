#!/bin/bash

ATT=
if [ $# -eq 1 ]; then
	ATT="-quickstart=$1"
fi

START="java -mx1024m -jar cooja/dist/cooja.jar $ATT  -external_tools_config=\"config/external_tools_linux.config\" "

echo Starting: $START
$START

