#!/bin/bash
set -e
source config.sh


APPCP='rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*" '

mkdir -p $BUILD



#rm -rf $DST
mkdir -p $DST

# >>>>>>>>>>>>> Contiki

BP=$BUILD/contiki
if [ ! -d  $BP ] ; then
	git clone git://i4git.informatik.uni-erlangen.de/contiki.git $BP
fi

cd  $BP
git fetch origin
git checkout origin/master

WP=$BP/tools/cooja

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

BP=$BUILD/realsim
if [ ! -d  $BP ] ; then
	git clone git://i4git.informatik.uni-erlangen.de/contiki_projects.git $BP
fi

cd  $BP
git fetch origin
git checkout origin/realsim

WP=$BP/cooja/apps/realsim

cd $WP
ant "-Dcooja=$DST" jar
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*"  $WP $DST/apps  

# >>>>>>>>>>>> DryRun

BP=$BUILD/dryrun
if [ ! -d  $BP ] ; then
	git clone ssh://gitosis@i4git.informatik.uni-erlangen.de/rdsp_dryrun.git $BP
fi

cd  $BP
git fetch origin
git checkout origin/sqlite

WP=$BP

cd $WP
ant "-Dcooja=$DST"
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*" 	 $WP $DST/apps  

		




