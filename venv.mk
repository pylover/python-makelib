.PHONY: venv
venv:
ifeq ($(shell echo $(PREFIX) | cut -d'/' -f2), usr)
	@echo "Cannot create venv on $(PREFIX)"
else
	python3 -m venv $(PREFIX)
endif


ifeq ("", "$(filter $(NOVENVREQUIRED_RULES), $(MAKECMDGOALS))")
  ifeq ("", "$(wildcard ${PREFIX}/bin)")
    $(error No virtual environemnt exists at ${PREFIX}, please create one with \
  	  `make venv`)
  endif
endif



.PHONY: venv-delete
venv-delete: clean
ifeq ($(shell echo $(PREFIX) | cut -d'/' -f2), usr)
	@echo "Cannot delete venv: $(PREFIX)"
else
	-rm -rf $(PREFIX)
endif


.PHONY: fresh
fresh: venv-delete venv


activate.sh:
	ln -s $(PYTHON_MAKELIB_PATH)/activate.sh .
