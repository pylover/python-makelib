TWINE ?= $(PREFIX)/bin/twine


.PHONY: pypi
pypi: clean sdist wheel
	$(TWINE) upload dist/*.gz dist/*.whl
