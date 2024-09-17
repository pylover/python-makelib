PYDEPS_COMMON += build


.PHONY: sdist
sdist: setup.py
	$(PY) -m build --sdist


.PHONY: bdist
wheel: setup.py
	$(PY) -m build --wheel


.PHONY: dist
dist: sdist wheel


.PHONY: clean
clean::
	-rm -rf dist/*
