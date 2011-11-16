#!/bin/bash
set -e

HERE=$PWD
COOJAPATH=/proj/mmtmp41/morty/git/rdsp_simulation/tools/cooja

echo $HERE

cd $COOJAPATH 
ant jar
cp -r $COOJAPATH/dist $HERE

mkdir -p $HERE/apps

for F in  $COOJAPATH/apps/*
do
	set +e
	cd $F &&  ant  && cp -r $F $HERE/apps
	set -e
done
		


