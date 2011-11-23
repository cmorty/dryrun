#!/bin/bash
set -e
COOJAPATH=/proj/mmtmp41/morty/git/rdsp_simulation/tools/cooja


HERE=$PWD/cooja

#rm -rf $HERE
mkdir -p $HERE


cd $COOJAPATH 
ant jar
cp -r $COOJAPATH/dist $HERE

mkdir -p $HERE/apps

for F in  $COOJAPATH/apps/*
do
	set +e
	#cd $F &&  ant  && rsync --delete -avm --include "*/" --include"*.config" --include "*.jar" --exclude "*"  $F $HERE/apps  
	cd $F &&  ant  && rsync --delete -avm --include "*/" --include "*.config" --include "*.jar"  $F $HERE/apps  
	set -e
done
		



