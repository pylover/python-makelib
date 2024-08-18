.PHONY: doc
doc:
	cd $(SPHINX_PATH); make html


.PHONY: doctest
doctest:
	cd $(SPHINX_PATH); make doctest


.PHONY: livedoc
livedoc:
	cd $(SPHINX_PATH); make livehtml
