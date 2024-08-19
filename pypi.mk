TWINE ?= $(PREFIX)/bin/twine


.PHONY: pypi
pypi: clean dist
	$(TWINE) upload dist/*.gz dist/*.whl
