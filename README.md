# python-makelib

## How to use

### Setup

#### Close this repo as a git submodule
```bash
git submodule add git@github.com:pylover/python-makelib.git make
```

#### Create a Makefile
Create a `Makefile` in your project's root:
```make
PREFIX = path/to/venv
PKG_NAME = 'foo-bar'
include make/common.mk
include make/test.mk
include make/sphinx.mk
include make/pypi.mk
```

### Usage

#### common.mk
##### Virtual environment
```bash
# Create a virtual environment by `python -m venv $(PREFIX)`
make venv

# Delete the virtualenv
make venv-delete

# Delete and re-create a fresh virtual environment
make venv-fresh
```

##### Project Installation
```bash
# Normal installation using pip
make install

# Editable instllation using pip -e
make install-editable

# pip uninstall
make uninstall

# install-editable + pip -r requirements-dev.txt
make env

# install-editable + pip -r requirements-ci.txt
make env ENV=ci
```

##### Python Distribution
```bash
# Create a source districution
make sdist


# Create a wheel(binary) districution
make wheel


# sdist + wheel
make dist

# Cleanup the dist/* directory
make dist-clean
```

##### Lint
```bash
# Lint using flake8
make lint
```

##### Cleanup
```bash
# Delete everything inside the dist/* and build/* directories
make clean 
```


#### test.mk
```bash
# Run tests using pytest
make test

# Run a specific test
make test F=tests/test_foo.py::test_barfunc

# Run test + coverage
make cover

# Generate HTML code coverage report
make cover-html
```

#### pypi.mk
To upload the source and binary(`wheel`) files to pypi using `twine`:
```bash
make pypi
```

#### sphinx.mk
```bash
# Generate html documentation
make doc

# Run documentation tests
make doctest

# Documentation HTTP server
make livedoc
```
