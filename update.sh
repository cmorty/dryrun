#!/bin/bash
set -e

BUILD=/build/morty/cooja_build
DST=/build/morty/cooja


mkdir -p $BUILD



#rm -rf $DST
mkdir -p $DST

# >>>>>>>>>>>>> Contiki

BP=$BUILD/contiki
if [ ! -d  $BP ] ; do
	git clone git://i4git.informatik.uni-erlangen.de/contiki.git $BP
done

cd  $BP
git fetch origin
git checkout origin/master

WP=$PB/tools/cooja

cd $WP
ant jar
WP -r dist $DST

# >>> Plugins


mkdir -p $DST/apps

for F in  $WP/apps/*
do
	set +e
	cd $F &&  ant  && rsync --delete -avm --include "*/" --include "*.config" --include "*.jar"  $F $DST/apps  
	set -e
done

# >>>>>>>>>>>>> RealSim

BP=$BUILD/realsim
if [ ! -d  $BP ] ; do
	git clone git://i4git.informatik.uni-erlangen.de/contiki_projects.git $BP
done

cd  $BP
git fetch origin
git checkout origin/realsim

WP=$PB/cooja/apps/realsim

cd $WP
ant "-Dcooja=$DST"
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar"  $WP $DST/apps  

# >>>>>>>>>>>> DryRun

BP=$BUILD/dryrun
if [ ! -d  $BP ] ; do
	git clone ssh://gitosis@i4git:rdsp_dryrun.git $BP
done

cd  $BP
git fetch origin
git checkout origin/sqlite

WP=$PB

cd $WP
ant "-Dcooja=$DST"
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar"  $WP $DST/apps  

		



