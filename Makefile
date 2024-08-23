# python-makelib directory relative to user's Makefile.
PYTHON_MAKELIB_VERSION = 1.1.1


PREFIX ?= /usr/local/lib
TARGET ?= python-makelib
INSTALL_FILES = \
	activate.sh \
	common.mk \
	dist.mk \
	install.mk \
	lint.mk \
	pypi.mk \
	release.sh \
	sphinx.mk \
	test.mk \
	venv.mk


.PHONY: install
install:
	- mkdir -p $(PREFIX)/$(TARGET)
	cp $(INSTALL_FILES) $(PREFIX)/$(TARGET)


dist/python-makelib-$(PYTHON_MAKELIB_VERSION).tar.gz:
	- rm -rf dist/$(TARGET)
	- mkdir -p dist/$(TARGET)
	cp $(INSTALL_FILES) dist/$(TARGET)
	cd dist; tar -cvf ../$@ $(TARGET)


.PHONY: dist
dist: dist/python-makelib-$(PYTHON_MAKELIB_VERSION).tar.gz


.PHONY: clean
clean::
	- rm -rf dist
