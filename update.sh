#!/bin/bash
set -e
source config.sh


APPCP='rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*" '

mkdir -p $BUILD

#Get absolute paths
if [ -d  $BUILD_CONTIKI ] ; then BUILD_CONTIKI=`readlink -f $BUILD_CONTIKI ` ;fi
if [ -d  $BUILD_COOJA   ] ; then BUILD_COOJA=`  readlink -f $BUILD_COOJA `   ;fi
if [ -d  $BUILD_REALSIM ] ; then BUILD_REALSIM=`readlink -f $BUILD_REALSIM ` ;fi
if [ -d  $BUILD_TRACE   ] ; then BUILD_TRACE=`  readlink -f $BUILD_TRACE `   ;fi




#rm -rf $DST
mkdir -p $DST
if [ `readlink -f ./cooja` != `readlink -f $DST` ] ; then 
	rm -f ./cooja
	ln -s $DST cooja
fi


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

WP=$BP

cd $WP
ant "-Dcooja=$DST" jar
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --exclude "*" --include "lib/**" $WP/ $DST/apps/realsim/

# >>>>>>>>>>>> CoojaTrace

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
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --include "lib/**" --exclude "*" $WP/ "$DST/apps/trace"

		

# >>>>>>>>>>>> CoojaTraceSqlite

BP=$BUILD_TRACE_SQLITE
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
ant "-Dcooja=$DST" "-Dcoojatrace=$BUILD_TRACE"
rsync --delete -avm --include "*/" --include "*.config" --include "*.jar" --include "lib/**" --exclude "*" $WP/ "$DST/apps/trace-sqlite"




