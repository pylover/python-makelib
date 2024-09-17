PYTHON_MAKELIB_URL ?= https://github.com/pylover/python-makelib
PYTHON_MAKELIB_VERSION = 1.7.4


version_greater_equal = $(shell if printf '%s\n%s\n' '$(1)' \
	'$(PYTHON_MAKELIB_VERSION)' | \
    sort -Ct. -k1,1n -k2,2n ; then echo YES; else echo NO; fi )


ifneq ("$(PYTHON_MAKELIB_VERSION_REQUIRED)", "")
ifneq (YES,$(call version_greater_equal,$(PYTHON_MAKELIB_VERSION_REQUIRED)))
  $(error your python-makelib v$(PYTHON_MAKELIB_VERSION) is outdated. \
    install the python-makelib v$(PYTHON_MAKELIB_VERSION_REQUIRED) or \
    higher from "$(PYTHON_MAKELIB_URL)")
endif
endif
