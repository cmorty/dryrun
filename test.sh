#!/bin/bash

if [ $# -lt 1 -o $# -gt 2 ]; then
  echo "Usage: $0 <test> [logfile]"
  exit
fi

TEST=$1

LOG=/dev/null
if [ $# -eq 2 ]; then
	LOG=$2
	echo ">>>>>>> Logging to: $LOG <<<<<<<<"
fi

echo ">>>>>>> Starting test: $TEST <<<<<<<<"
echo -n "[`date '+%F %T'`] $TEST: " >> $LOG
if [ -f "COOJA.log" ]; then
  rm COOJA.log
fi
if [ -f "COOJA.testlog" ]; then
  rm COOJA.testlog
fi
java -mx512m -jar cooja/dist/cooja.jar -nogui=$TEST.csc -external_tools_config="config/external_tools_linux.config"
if [ -f "COOJA.log" ]; then
  mv COOJA.log $TEST.cooja_log
fi
if [ -f "COOJA.testlog" ]; then
  mv COOJA.testlog $TEST.log
fi

OK=0
if [ -f "$TEST.log" ]; then
  OK=`grep "TEST OK" $TEST.log | wc -l`
fi

if [ $OK == 0 ]; then
  echo "FAIL" >> $LOG
else
  echo "OK" >> $LOG
fi

echo >> $LOG

if [ -f "$TEST.info" ]; then
	echo "-- TEST INFO ($TEST.info) --" >> $LOG
	cat $TEST.info >> $LOG
else
	echo "-- NO TEST INFO AVAILABLE ($TEST.info) --" >> $LOG
fi

if [ -f "$TEST.log" ]; then
	echo "-- TEST OUTPUT (tail $TEST.log) --" >> $LOG
	cat $TEST.log >> $LOG
else
	echo "-- NO TEST OUTPUT AVAILABLE ($TEST.log) --" >> $LOG
fi

echo "-- COOJA OUTPUT (tail $TEST.cooja_log) --" >> $LOG
cat $TEST.cooja_log >> $LOG

echo >> $LOG


if [ $OK == 0 ]; then
	echo ">>>>>>> Finished test: $TEST FAILED <<<<<<<<"
	echo ""
	exit 1
else
	echo ">>>>>>> Finished test: $TEST OK <<<<<<<<"
	echo ""
	exit 0
fi

