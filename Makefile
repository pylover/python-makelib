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
	
