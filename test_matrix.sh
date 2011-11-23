#!/bin/bash

set -e

#LOG="TEST-`date '+%F'`.log"
LOG=currentlog.log
MAIL=0
CVS=0
WORKDIR=./workdir
TESTDIR=./tests
LOGDIR=./logs
PROGNAME=`basename $0`
REV=HEAD
RGIT="git://contiki.git.sourceforge.net/gitroot/contiki/contiki"
TESTS="collect_10sky-times-contiki.csc"


TESTDIR=`readlink -f ${TESTDIR}`


echo ">>>>>>> Creating test log <<<<<<<<"
touch $LOG


echo ">>>>>>> Preparing GIT <<<<<<<<"



mkdir -p $WORKDIR
cd $WORKDIR 
	if [ ! -d ".git" ]; then
		git clone $RGIT .
	fi
	REVS=`git log -100 --pretty=format:%h`
cd ..	


for REV in $REVS
do
	cd $WORKDIR 
		git checkout $REV 
		git clean -f -d
		REVSHA1=`git show -s --format="%h"`
		REVDATE=`git show -s --format="%ct"`
	cd ..

	mkdir -p $LOGDIR
	LOG=$LOGDIR/${REVDATE}_${REVSHA1}

	echo >> $LOG
	for TEST in $TESTS
	do
		TESTNAME=`basename $TEST .csc`  	
		TEST=$TESTDIR/$TESTNAME
		echo ">>>>>> calling $TEST > $LOG "
		echo ">>>>>> ./test.sh $TEST ${LOG}_${TESTNAME} "
		./test.sh $TEST ${LOG}_${TESTNAME} || true
	done
done

