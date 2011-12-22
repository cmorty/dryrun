#!/usr/bin/make



include	config.sh

export LOG=currentlog.log
export WORKDIR=/build/morty/workdir
export TESTDIR=$(abspath ./tests)
export LOGDIR=$(abspath ./logs)
export PROGNAME=`basename $0`
export RGIT="git://contiki.git.sourceforge.net/gitroot/contiki/contiki"
export COOJA:=$(subst ", ,$(COOJA))
export LOG_PARA=--since=2009
export GITDIR=/build/morty/gitdir

export TESTS=sky_collect_final

export BROKENREVS=3034ac4 76a8e49 17e7827 659be7c dc9cbe6


include runtest.mk


#%:
#	$(MAKE) -r -f runtest.mk $@ 



