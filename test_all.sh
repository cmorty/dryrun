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

Usage() {
  echo >&2 "$PROGNAME:" "$@"
  echo >&2 "Usage: $PROGNAME [-cvs] [-mail] [-ref GITREV]"
  exit 10
}

while [ $# -gt 0 ]; do
	case "$1" in
  		-cvs) CVS=1 ;;
		-mail) MAIL=1 ;;
		-rev) 
			shift
			REV=$1
		;;
		*) Usage "Unknown option \"$1\"" ;;
  	esac
	shift
done

if [ -z "$CONTIKI" ]; then
  if [ -z "$CONTIKI_HOME" ]; then
  	CONTIKI_HOME=../../..
    echo Undefined variable: CONTIKI_HOME. Using default: ${CONTIKI_HOME}
  fi
  CONTIKI=$CONTIKI_HOME
fi

if [ $MAIL -eq 1 ]; then
  if [ -z "$MAILTO" ]; then
    echo Undefined variable: MAILTO
    exit 1
  fi
fi

function mail_report() {
  if [ $MAIL -eq 1 ]; then
    echo ">>>>>>> Sending mail <<<<<<<<"
    echo "[`date '+%F %T'`] Mailing test report" >> $LOG
    cat $LOG | mail -s "Contiki test results" $MAILTO
    if [ "$?" -ne 0 ]; then
      echo "Failed to send mail"
      echo "[`date '+%F %T'`] MAIL FAILED" >> $LOG
    else
      echo "[`date '+%F %T'`] test report sent" >> $LOG
    fi
  else
    echo
    echo
    echo ">>>>>>> Test Report <<<<<<<<"
    cat $LOG
  fi
  cp $LOG RUN_ALL_LAST.log
}

echo ">>>>>>> Cleaning up previous tests <<<<<<<<"
rm -f *.log *.cooja_log
rm -fr se obj_cooja
rm -f symbols.c symbols.h

echo ">>>>>>> Creating test log <<<<<<<<"
touch $LOG


echo ">>>>>>> Preparing GIT <<<<<<<<"

mkdir -p $WORKDIR
cd $WORKDIR 
	if [ ! -d ".git" ]; then
		git clone $RGIT .
	fi

	git checkout $REV 
	git clean -f -d
	REVSHA1=`git show -s --format="%h"`
	REVDATE=`git show -s --format="%ct"`
cd ..

mkdir -p $LOGDIR
LOG=$LOGDIR/${REVDATE}_${REVSHA1}

echo >> $LOG
for file in $TESTDIR/*.csc
do
	TESTNAME=`basename $file .csc`  	
	TEST=$TESTDIR/$TESTNAME
	echo ###### calling #########
	./test.sh $TEST ${LOG}_${TESTNAME} || true
done

mail_report
