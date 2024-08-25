# python-makelib


## Install

```bash
curl "https://raw.githubusercontent.com/pylover/python-makelib/master/install.sh" | sudo sh
```

Or 
```bash
git clone <repo-url>
cd repo
sudo make install
sudo make install PREFIX=/opt
```

Or
```bash
git clone <repo-url>
cd repo
make clean dist
sudo tar -C /usr/local/lib -xvf python-makelib-*.tar.gz
```


## Setup your project:
Create a `Makefile` in your project's root:
```make
# The default location
PYTHON_MAKELIB_PATH = /usr/local/lib/python-makelib
# Or, the prefix already given to make install PREFIX=...
PYTHON_MAKELIB_PATH = /opt/python-makelib


# Python package name and namespace
PKG_NAMESPACE = foo.bar
PKG_NAME = foo-bar


# Common development depenndencies
PYDEPS_COMMON += \
    'baz' \
    'qux'

# documentation building depenndencies
PYDEPS_DOC += \
    'foo'

# local development and debugging dependencies such as debugging and etc.
PYDEPS_DEV += \
    'foo', \
    'bar'


# Ensure python-makelib is installed
ifeq ("", "$(wildcard $(PYTHON_MAKELIB_PATH))")
  PYTHON_MAKELIB_URL = https://github.com/pylover/python-makelib
  $(error python-makelib is not installed. see "$(PYTHON_MAKELIB_URL)")
endif


# Assert python-makelib version (optional)
PYTHON_MAKELIB_VERSION_REQUIRED ?= 1.2.0


# Then, include one of files below:
include $(PYTHON_MAKELIB_PATH)/venv-lint.mk
include $(PYTHON_MAKELIB_PATH)/venv-lint-pypi.mk
include $(PYTHON_MAKELIB_PATH)/venv-lint-test.mk
include $(PYTHON_MAKELIB_PATH)/venv-lint-test-pypi.mk
include $(PYTHON_MAKELIB_PATH)/venv-lint-test-doc.mk
include $(PYTHON_MAKELIB_PATH)/venv-lint-test-doc-pypi.mk
```


## Usage


### Activate the virtual environment
```bash
source make/activate.sh

# Or
ln -s make/activate.sh .
source activate.sh
```


### Variables
These variables may set by user before including any `*.mk` file(s). 

#### PKG_NAMESPACE
Full qualified package name for your project, for example: `yhttp.ext.pony`.
default is the name of `Makefile`'s directory.
```make
PKG_NAMESPACE ?= $(shell basename $(HERE))
```

#### PKG_NAME
Name of the Python package, the same as the `setup.py`'s `setup(name=...)`.
default is the name of `Makefile`'s directory.
```make
PKG_NAME ?= $(shell basename $(HERE))
```

#### VENV_NAME
The Python virtual environment to deal with it. default is the `PKG_NAME`.
```make
VENV_NAME ?= $(PKG_NAME)
```
> **_NOTE:_** the `VENV_NAME` variable will be ignored if the `PREFIX` is set.


#### PREFIX
Prefix path for Python's binaries and libraries (aka: virtual environment).
default is:
```make
PREFIX ?= $(HOME)/.virtualenvs/$(VENV_NAME)
```

### common.mk

> **_NOTE:_** `common.mk` must be included before any other file(s).

Run all quality assurance tests driven from imported files:
```bash
make qa
```

Find the version from the project's __init__.py and create a tagged commit,
and push with --tags
```bash
make release
```

Delete everything inside the dist/* and build/* directories
```bash
make clean 
```


### venv.mk

Create a virtual environment by `python -m venv $(PREFIX)`
```bash
make venv
```

Delete the virtualenv
```bash
make venv-delete
```

Delete and re-create a fresh virtual environment
```bash
make fresh
```

Delete and re-create a fresh virtual environment + editable mode install
```bash
make fresh env
```

Create a symbolic link to `activate.sh`:
```bash
make activate.sh
```

### install.mk

Normal project installation using the pip:
```bash
make install
```

Install PYDEPS_* packages:
```bash
make install-common
make install-dev
make install-doc
```

Editable project installation using `pip -e`:
```bash
make editable-install
```

Uninstall project using `pip uninstall`:
```bash
make uninstall
```

`editable-install` + `ENV_DEPS` rules which expanded by including various 
`*.mk` files. default: `ENV_DEPS = install-common install-dev`
```bash
make env
```


### lint.mk

Lint using flake8
```bash
make lint
```


### test.mk

Run tests using pytest
```bash
make test
```

Run a specific test
```bash
make test F=tests/test_foo.py::test_barfunc
```

Run test + coverage
```bash
make cover
```

Generate HTML code coverage report
```bash
make cover-html
```


### sphinx.mk

Generate html documentation
```bash
make doc
```

Run documentation tests
```bash
make doctest
```

Documentation HTTP server
```bash
make livedoc
```


### dist.mk
Create a `tar.gz` (source) districution
```bash
make sdist
```

Create a `wheel` (binary) districution
```bash
make wheel
```


`sdist` + `wheel`
```bash
make dist
```


### pypi.mk
To upload the source and binary(`wheel`) files to pypi using `twine`:
```bash
make pypi
```

> **_NOTE:_** `dist.mk` must be included before `pypi.mk`

### webapi.mk
Web API projects stuff.

#### WEBAPIDOC_PATH
Path to a directory which contains the web API documentation HTML files.
default: `apidoc`.

Serve API documentation HTML files: 
```bash
make webapi-serve
```
