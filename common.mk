# python-makelib directory relative to user's Makefile.
PYTHON_MAKELIB_DIR ?= make
PYTHON_MAKELIB_VERSION = 1.1.0


# Location of the user's Makefile file
HERE = $(shell readlink -f `dirname .`)


# These variables may set by user before including any *.mk file. 
PKG_NAMESPACE ?= $(shell basename $(HERE))
PKG_NAME ?= $(shell basename $(HERE))
VENV ?= $(PKG_NAME)
PREFIX ?= $(HOME)/.virtualenvs/$(VENV)
ENV_DEPS += install-common install-dev


# Dependencies per environment: common, dev, doc, etc.
# local:	common  doc  dev
# cidoc:    common  doc
# cibuild:  common 
# cipypi:   common  
DEPS_COMMON += setuptools
DEPS_DEV += \
	pytest-pudb \
	ipython


# Internal variables
PY ?= $(PREFIX)/bin/python3
PIP ?= $(PREFIX)/bin/pip3
QA ?= 


.PHONY: qa
qa:
	make $(QA)


.PHONY: release
release:
	$(PYTHON_MAKELIB_DIR)/release.sh $(HERE) $(PKG_NAMESPACE)


.PHONY: clean
clean::
	-rm -rf build/*
