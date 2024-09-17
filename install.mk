.PHONY: install
install: setup.py
	$(PIP) install .


.PHONY: editable-install
editable-install: setup.py
	$(PIP) install -e .


.PHONY: uninstall
uninstall:
	$(PIP) uninstall -y $(PKG_NAME)


.PHONY: install-%
install-%:
	$(PIP) install $(foreach p,\
		$(PYDEPS_$(shell echo '$*' | tr '[:lower:]' '[:upper:]')),$(p))
	

.PHONY: env
env:
	@make $(ENV_DEPS) editable-install
