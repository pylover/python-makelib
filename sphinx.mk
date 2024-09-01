SPHINX_PATH ?= sphinx
QA += doctest
ENV_DEPS += install-doc
PYDEPS_DOC += \
	'sphinx' \
	'sphinx-autobuild'


SPHINXBUILD=$(PREFIX)/bin/sphinx-build
export SPHINXBUILD


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
ifneq ("", "$(wildcard $(SPHINXBUILD))")
	cd $(SPHINX_PATH); make clean
endif
