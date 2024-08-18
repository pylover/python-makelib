HERE = $(shell readlink -f `dirname .`)
PKG_NAME ?= $(shell basename $(HERE))
VENV ?= $(PKG_NAME)
PREFIX ?= $(HOME)/.virtualenvs/$(VENV)
PY ?= $(PREFIX)/bin/python3
PIP ?= $(PREFIX)/bin/pip3
COVERAGE ?= $(PREFIX)/bin/coverage
FLAKE8 ?= $(PREFIX)/bin/flake8
SPHINX_PATH ?= sphinx
ENV ?= dev


# Virtual environment
.PHONY: venv
venv:
	python3 -m venv $(PREFIX)


.PHONY: venv-delete
venv-delete: clean
	rm -rf $(PREFIX)


.PHONY: fresh
fresh: venv-delete venv


# Install
.PHONY: install
install:
	$(PIP) install .


.PHONY: install-editable
install-editable:
	$(PIP) install -e .


.PHONY: uninstall
uninstall:
	$(PIP) uninstall -y $(PKG_NAME)


.PHONY: env
env: install-editable
	$(PIP) install -r requirements-$(ENV).txt


# Distribution
.PHONY: sdist
sdist:
	$(PY) -m build --sdist


.PHONY: bdist
wheel:
	$(PY) -m build --wheel


.PHONY: dist
dist: sdist wheel


.PHONY: dist-clean
dist-clean:
	rm -rf dist/*


.PHONY: lint
lint:
	$(FLAKE8)


.PHONY: clean
clean: dist-clean
	rm -rf build/*
