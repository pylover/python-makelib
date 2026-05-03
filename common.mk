PYTHON_MAKELIB_PATH ?= /usr/local/lib/python-makelib
PYTHON_MAKELIB_VERSION_REQUIRED ?=
include $(PYTHON_MAKELIB_PATH)/_version.mk

# Location of the user's Makefile file
HERE = $(shell readlink -f `dirname .`)


# These variables may set by user before including any *.mk file. 
PKG_NAME ?= $(shell basename $(HERE))
PKG_NAMESPACE ?= $(shell echo $(PKG_NAME) | sed 's/-/_/g')
VENV_NAME ?= $(PKG_NAME)
PREFIX ?= $(HOME)/.virtualenvs/$(VENV_NAME)
VENV_DEPS ?=
VENV_DELETE_DEPS ?=
ENV_DEPS += install-common install-dev
ENV_POPSTDEPS ?=


# allow user to override timezone for development processes
ifdef TIMEZONE
export TZ=$(TIMEZONE)
endif


# Virtual environment is not required for these rules
NOVENVREQUIRED_RULES = \
	venv \
	fresh \
	setup.py \
	venvname \
	.gitignore \
	.coveragerc \
	.flake8 \
	README.md


# Dependencies per environment: common, dev, doc, etc.
# local:	common  doc  dev
# cidoc:    common  doc
# cibuild:  common 
# cipypi:   common  
PYDEPS_COMMON += setuptools
PYDEPS_DEV += \
   'pytest-pudb @ git+ssh://git@github.com/pylover/pytest-pudb.git' \
	ipython


# Internal variables
PY ?= $(PREFIX)/bin/python3
PIP ?= $(PREFIX)/bin/pip3
QA ?= 


# export variables
export PKG_NAME

.PHONY: qa
qa:
	make $(QA)


.PHONY: release
release:
	$(PYTHON_MAKELIB_PATH)/release.sh extract $(HERE) $(PKG_NAMESPACE)


setup.py:
	$(PYTHON_MAKELIB_PATH)/create-setup.py.sh $(PKG_NAME) $(PKG_NAMESPACE) \
		$(HERE) ${TEST_DIR}


.gitignore:
	cp $(PYTHON_MAKELIB_PATH)/gitignore.template $@


.coveragerc:
	envsubst < $(PYTHON_MAKELIB_PATH)/coveragerc.template > $@


.flake8:
	envsubst < $(PYTHON_MAKELIB_PATH)/flake8.template > $@


README.md:
	envsubst < $(PYTHON_MAKELIB_PATH)/readme.template > $@


.PHONY: clean
clean::
	-rm -rf build/*
