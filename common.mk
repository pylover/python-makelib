PYTHON_MAKELIB_PATH ?= /usr/local/lib/python-makelib
PYTHON_MAKELIB_VERSION_REQUIRED ?=
include $(PYTHON_MAKELIB_PATH)/_version.mk

# Location of the user's Makefile file
HERE = $(shell readlink -f `dirname .`)


# These variables may set by user before including any *.mk file. 
PKG_NAMESPACE ?= $(shell basename $(HERE))
PKG_NAME ?= $(shell basename $(HERE))
VENV_NAME ?= $(PKG_NAME)
PREFIX ?= $(HOME)/.virtualenvs/$(VENV_NAME)
ENV_DEPS += install-common install-dev
AUTHOR ?= 
AUTHOR_EMAIL ?= 
DESCRIPTION ?= 


# Virtual environment is not required for these rules
NOVENVREQUIRED_RULES = venv fresh setup.py


# Dependencies per environment: common, dev, doc, etc.
# local:	common  doc  dev
# cidoc:    common  doc
# cibuild:  common 
# cipypi:   common  
PYDEPS_COMMON += setuptools
PYDEPS_DEV += \
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
	$(PYTHON_MAKELIB_PATH)/release.sh extract $(HERE) $(PKG_NAMESPACE)


setup.py:
	$(PYTHON_MAKELIB_PATH)/create-setup.py.sh $(PKG_NAME) $(PKG_NAMESPACE) \
		$(HERE) $(AUTHOR) $(AUTHOR_EMAIL) $(DESCRIPTION) ${TEST_DIR}


.PHONY: clean
clean::
	-rm -rf build/*
