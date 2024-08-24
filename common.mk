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
	$(PYTHON_MAKELIB_PATH)/release.sh $(HERE) $(PKG_NAMESPACE)


.PHONY: clean
clean::
	-rm -rf build/*


activate.sh:
	ln -s $(PYTHON_MAKELIB_PATH)/activate.sh .
