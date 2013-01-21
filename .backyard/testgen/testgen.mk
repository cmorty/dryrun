.PHONY: createtest testgen.log


createtest: testgen.log
	

testgen.log: testconfig.php $(DRYRUNDIR)/testgen/testgen.php
	php $(DRYRUNDIR)/testgen/testgen.php testconfig.php > testgen.log || cat testgen.log
	