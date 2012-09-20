#!/usr/bin/make



include	config.sh

export JOBDIR=jobs
export LOG=currentlog.log
export WORKDIR=/build/morty/workdir
export TESTDIR=$(abspath ./tests)
export LOGDIR=$(abspath ./logs)
export PROGNAME=`basename $0`
export RGIT="git://contiki.git.sourceforge.net/gitroot/contiki/contiki"
export COOJA:=$(subst ", ,$(COOJA))
export LOG_PARA=--since=2007-01-01 -- core cpu/msp430 plattform/sky
export GITDIR=/build/morty/gitdir

export TESTS=sky_collect_final

export BROKENREVS=3034ac4 76a8e49 17e7827 659be7c dc9cbe6
export BROKENREVS+= `cat boken_git.txt`

include runtest.mk


#%:
#	$(MAKE) -r -f runtest.mk $@ 



