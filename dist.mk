PYDEPS_COMMON += build


.PHONY: sdist
sdist: setup.py
	$(PY) -m build --sdist


.PHONY: wheel
wheel: setup.py
	$(PY) -m build --wheel


.PHONY: clean
clean::
	-rm -rf dist/*
