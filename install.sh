#! /usr/bin/env bash

cd $(mktemp -d)
git clone https://github.com/pylover/python-makelib.git
cd python-makelib
make install
