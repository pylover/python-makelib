TWINE ?= $(PREFIX)/bin/twine


.PHONY: pypi
pypi: dist-clean dist
	$(TWINE) upload dist/*.gz dist/*.whl
