#LOG="TEST-`date '+%F'`.log"


CONTIKIPATHS=apps core cpu examples platform Makefile.include tools/empty-symbols.c tools/empty-symbols.h tools/make-empty-symbols Makefile scan-neighbors.c
CONTIKIPATHS= Makefile scan-neighbors.c
JOBS=$(wildcard $(JOBDIR)/*.job)
JOBSD=$(patsubst %.job, %.done, $(JOBS))


include $(JOBDESC)

export GITREV
export CFLAGS
	
$(JOBDIR)/%.data: $(WORKDIR)/%/COOJA.done  $(JOBDIR)/%.job
	@echo "Pos 1"
	mkdir -p $@
	cp $(<D)/COOJA.log $@  
	-cp $(<D)/COOJA.testlog $@
	touch $(<D)/dummy__.db
	for F in $(<D)/*.db ;\
		do echo "Moving  $${F} to $@" ; \
		cp $${F} $@ ; \
	done ; 	
	rm $@/dummy__.db
	touch $(@D)/$*.done


# Run Cooja
%/COOJA.done:  %/checkout.done %/log4j_config.xml
	rm -f  $*/Cooja.failed $*/*.db $*/COOJA.testlog
	cd $* && $(COOJA) -nogui=$(TESTDIR)/$(TEST).csc   -external_tools_config=$(COOJACONFIG) -contiki=$*  -log4j=$*/log4j_config.xml || touch $*/Cooja.failed
	touch $@


%/log4j_config.xml: %/checkout.done
%/log4j_config.xml:: config/log4j_config.xml  
	cat $< | sed 's%COOJA.log%$*/COOJA.log%'  > $@



# Export Contiki in an extra path
%/checkout.done: $(GITDIR)
	echo "$*"
	# cleanup
	rm -rf "$(@D)"
	mkdir -p "$(@D)"
	git --git-dir=$(GITDIR)/.git archive --format=tar $(GITREV) $(CONTIKIPATHS)  | (cd "$(@D)" && tar xf -) || echo $(GITREV) >> $(WORKDIR)/boken_git.txt
	touch $@
	$(MAKE) $*/log4j_config.xml
	

# This is the main job
# A new Make is forked to ensure that each set is done one by one
# It is the request to create the folder
%.done: %.job $(GITDIR)
	rm -f $@
	$(MAKE) $*.data JOBDESC=$<
		

		
#matrix:	REVS:=$(shell cd $(GITDIR) && git log $(LOG_PARA) --pretty=format:%h )
#matrix: REVL=$(patsubst %,$(LOGDIR)/%, $(REVS))
#matrix: $(foreach TEST,$(TESTS), $(patsubst %,%#$(TEST).log, $(REVL)))
matrix: $(JOBSD)



$(GITDIR)/.git: 
	mkdir -p $(GITDIR)
	git clone $(RGIT) $(GITDIR) 


$(GITDIR): $(GITDIR)/.git
#	cd $@ && git fetch && git rebase origin/master



.PHONY: $(GITDIR)
	
.PRECIOUS: $(GITDIR) %/Makefile.include %/COOJA.log %/COOJA.done %/log4j_config.xml
	

info:
	@echo  $(TESTDIR)
	@echo  $(COOJACONFIG)
	@echo  $(COOJA)
	@echo  $(JOBS)
	@echo  $(JOBSD)

