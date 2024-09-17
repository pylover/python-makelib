PYTHON_MAKELIB_PATH = .
PYTHON_MAKELIB_VERSION_REQUIRED ?=
include _version.mk


PREFIX ?= /usr/local/lib
TARGET ?= python-makelib
INSTALL_FILES = \
	_version.mk \
	activate.sh \
	common.mk \
	dist.mk \
	install.mk \
	lint.mk \
	pypi.mk \
	sphinx.mk \
	test.mk \
	venv.mk \
	webapi.mk \
	venv-lint.mk \
	venv-lint-pypi.mk \
	venv-lint-test.mk \
	venv-lint-test-webapi.mk \
	venv-lint-test-pypi.mk \
	venv-lint-test-doc.mk \
	venv-lint-test-doc-pypi.mk \
	release.sh \
	create-setup.py.sh



.PHONY: install
install:
	install -D -t $(PREFIX)/$(TARGET) $(INSTALL_FILES)


dist/python-makelib-$(PYTHON_MAKELIB_VERSION).tar.gz:
	- rm -rf dist/$(TARGET)
	- mkdir -p dist/$(TARGET)
	cp $(INSTALL_FILES) dist/$(TARGET)
	cd dist; tar -cvf ../$@ $(TARGET)


.PHONY: dist
dist: dist/python-makelib-$(PYTHON_MAKELIB_VERSION).tar.gz


.PHONY: release
release:
	./release.sh $(PYTHON_MAKELIB_VERSION)


.PHONY: clean
clean::
	- rm -rf dist
