#! /usr/bin/env bash

cd $(mkdtemp -d)
git clone https://github.com/pylover/python-makelib.git
cd python-makelib
make install
