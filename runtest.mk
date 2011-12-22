#LOG="TEST-`date '+%F'`.log"


CONTIKIPATHS=apps core cpu examples platform Makefile.include tools/empty-symbols.c tools/empty-symbols.h

	
$(LOGDIR)/%.log: $(WORKDIR)/%/COOJA.done 
	cp $(<D)/COOJA.log $@  
	cd $(<D); \
	if [ -f *.trace ] ; then \
		for F in *.trace ;\
			do echo "Moving  $${F} to $(LOGDIR)/$(*).$${F}" ; \
			cp $${F} $(LOGDIR)/$(*).$${F} ; \
		done ; \
	fi



%/COOJA.done: %/log4j_config.xml
	rm -f  $(@D)/Cooja.failed
	$(MAKE) $(firstword $(subst #, ,$*))/Makefile.include 
	-cd $(@D) && $(COOJA) -nogui=$(TESTDIR)/$(lastword $(subst #, ,$*)).csc   -external_tools_config=$(COOJACONFIG) -contiki=$(firstword $(subst #, ,$(@D)))  -log4j=$*/log4j_config.xml || touch $(@D)/Cooja.failed
	touch $@



#%/log4j_config.xml: %/.git 

%/log4j_config.xml:: config/log4j_config.xml
	mkdir -p $(@D)
	cat $< | sed 's%COOJA.log%$*/COOJA.log%'  > $@


%/Makefile.include: $(GITDIR)
	mkdir -p $(@D)
	git --git-dir=$(GITDIR)/.git archive --format=tar $(notdir $*) $(CONTIKIPATHS)  | (cd $(@D) && tar xf -) || echo $(notdir $*) >> $(WORKDIR)/boken_git.txt
	

		
#matrix:	REVS:=$(shell cd $(GITDIR) && git log $(LOG_PARA) --pretty=format:%h )
#matrix: REVL=$(patsubst %,$(LOGDIR)/%, $(REVS))
#matrix: $(foreach TEST,$(TESTS), $(patsubst %,%#$(TEST).log, $(REVL)))
matrix: $(foreach TEST,$(TESTS), $(patsubst %,%#$(TEST).log, $(patsubst %,$(LOGDIR)/%, $(filter-out $(BROKENREVS), $(shell cd $(GITDIR) && git log $(LOG_PARA) --pretty=format:%h )))))
matrix: $(GITDIR)
	echo "MATRIX"



$(GITDIR)/.git: 
	mkdir -p $(GITDIR)
	git clone $(RGIT) $(GITDIR) 


$(GITDIR): $(GITDIR)/.git
#	cd $@ && git fetch && git rebase origin/master



.PHONY: $(GITDIR)
	
.PRECIOUS: $(GITDIR) %/Makefile.include %/COOJA.log %/COOJA.done
	

info:
	echo  $(TESTDIR)
	echo  $(COOJACONFIG)
	echo  $(COOJA)
