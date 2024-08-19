DEPS_COMMON += build


.PHONY: sdist
sdist:
	$(PY) -m build --sdist


.PHONY: bdist
wheel:
	$(PY) -m build --wheel


.PHONY: dist
dist: sdist wheel


.PHONY: clean
clean::
	-rm -rf dist/*
