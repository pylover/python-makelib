FLAKE8 ?= $(PREFIX)/bin/flake8
QA += lint
DEPS_COMMON += flake8


.PHONY: lint
lint:
	$(FLAKE8)
