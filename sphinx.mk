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
	@make -C $(SPHINX_PATH) html


.PHONY: doctest
doctest:
	@make -C $(SPHINX_PATH) doctest


.PHONY: livedoc
livedoc:
	cd $(SPHINX_PATH); make livehtml


.PHONY: clean
clean::
ifneq ("", "$(wildcard $(SPHINXBUILD))")
	@make -C $(SPHINX_PATH) clean
endif
