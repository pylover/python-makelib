.PHONY: venvname
venvname:
	@echo $(VENV_NAME)


$(PREFIX):
ifeq ($(shell echo $(PREFIX) | cut -d'/' -f2), usr)
	@echo "Cannot create venv on $(PREFIX)"
else
	python3 -m venv $(PREFIX)
endif


venv: $(VENV_DEPS) $(PREFIX)


ifeq ("", "$(filter $(NOVENVREQUIRED_RULES), $(MAKECMDGOALS))")
  ifeq ("", "$(wildcard ${PREFIX}/bin)")
    $(error No virtual environemnt exists at ${PREFIX}, please create one with \
  	  `make venv`)
  endif
endif


.PHONY: venv-delete
venv-delete: $(VENV_DELETE_DEPS) clean
ifeq ($(shell echo $(PREFIX) | cut -d'/' -f2), usr)
	@echo "Cannot delete venv: $(PREFIX)"
else
	-rm -rf $(PREFIX)
endif


.PHONY: fresh
fresh: venv-delete venv


activate.sh:
	ln -s $(PYTHON_MAKELIB_PATH)/activate.sh .
