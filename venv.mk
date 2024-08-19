.PHONY: venv
venv:
	python3 -m venv $(PREFIX)


.PHONY: venv-delete
venv-delete: clean
	-rm -rf $(PREFIX)


.PHONY: fresh
fresh: venv-delete venv
