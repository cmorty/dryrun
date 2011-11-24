#!/bin/bash
set -e
source config.sh


APPCP='rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*" '

mkdir -p $BUILD



#rm -rf $DST
mkdir -p $DST

# >>>>>>>>>>>>> Contiki

BP=$BUILD_CONTIKI
if [ ! -d  $BP ] ; then
	git clone git://i4git.informatik.uni-erlangen.de/contiki.git $BP
fi

if [ $UPDATE_GIT = "true" ] ; then
	cd  $BP
	git fetch origin
	git checkout origin/master
fi

WP=$BUILD_COOJA

cd $WP
ant jar
cp -r dist $DST

# FIXME: This should not be needed in future (dryrun)
cp -r lib $DST
# >>> Plugins


mkdir -p $DST/apps

for F in  $WP/apps/*
do
	set +e
	cd $F &&  ant  && rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*"   $F $DST/apps  
	set -e
done

# >>>>>>>>>>>>> RealSim

BP=$BUILD_REALSIM
if [ ! -d  $BP ] ; then
	git clone git://i4git.informatik.uni-erlangen.de/contiki_projects.git $BP
	cd $BP
	git checkout origin/realsim -b realsim -t
fi

if [ $UPDATE_GIT = "true" ] ; then
	cd  $BP
	git fetch origin
	git checkout origin/realsim
fi

WP=$BP/cooja/apps/realsim

cd $WP
ant "-Dcooja=$DST" jar
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*"  $WP $DST/apps  

# >>>>>>>>>>>> DryRun

BP=$BUILD_TRACE
if [ ! -d  $BP ] ; then
	git clone ssh://gitosis@i4git.informatik.uni-erlangen.de/rdsp_dryrun.git $BP
	cd $BP
	git checkout origin/sqlite -b sqlite -t
fi

if [ $UPDATE_GIT = "true" ] ; then
	cd  $BP
	git fetch origin
	git checkout origin/sqlite
fi

WP=$BP

cd $WP
ant "-Dcooja=$DST"
cd $WP/sqlite
ant "-Dcooja=$DST"
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*" 	 $WP $DST/apps  

		




