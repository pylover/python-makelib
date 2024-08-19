SPHINX_PATH ?= sphinx
QA += doctest
ENV_DEPS += install-doc
DEPS_DOC += sphinx


.PHONY: doc
doc:
	cd $(SPHINX_PATH); make html


.PHONY: doctest
doctest:
	cd $(SPHINX_PATH); make doctest


.PHONY: livedoc
livedoc:
	cd $(SPHINX_PATH); make livehtml


.PHONY: clean
clean::
	cd $(SPHINX_PATH); make clean
