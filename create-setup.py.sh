#! /usr/bin/env bash
set -e


PKG_NAME=$1
PKG_NAMESPACE=$2
WORKINGCOPY_PATH=$3
AUTHOR=$4
AUTHOR_EMAIL=$5
DESCRIPTION=$6
TEST_DIR=$7


usage() {
  echo "Usage: create-setup.py.sh PKG_NAMESPACE PKG_NAME WORKINGCOPY_PATH " \
    "AUTHOR AUTHOR_EMAIL DESCRIPTION [TEST_DIR]" >&2
}


if [ -z "${PKG_NAME}" ] || [ -z "${PKG_NAMESPACE}" ]; then
  usage
fi


if [ -z "${WORKINGCOPY_PATH}" ]; then
  WORKINGCOPY_PATH=$(realpath .)
fi


if [ -z "$(echo ${PKG_NAMESPACE} | grep '\.')" ]; then
  FINDPKG="find_packages"
else
  FINDPKG="find_namespace_packages"
fi


if [ -n "${TEST_DIR}" ]; then
  FINDPKG_EXCLUDE="\n        exclude=['${TEST_DIR}']"
fi


PKG_PATH=$(echo ${PKG_NAMESPACE} | sed 's|\.|/|g')


echo "# This file is generated by https://github.com:pylover/python-makelib
import os.path
import re

from setuptools import setup, ${FINDPKG}


# reading package's version (same way sqlalchemy does)
with open(
    os.path.join(os.path.dirname(__file__), '${PKG_PATH}', '__init__.py')
) as v_file:
    package_version = \\
        re.compile('.*__version__ = \'(.*?)\'', re.S) \\
        .match(v_file.read()) \\
        .group(1)


dependencies = [
    # TODO: dependencies
]


setup(
    name='${PKG_NAME}',
    version=package_version,
    author='${AUTHOR}',
    author_email='${AUTHOR_EMAIL}',
    url='http://github.com/yhttp/yhttp',
    description='${DESCRIPTION}',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',  # This is important!
    install_requires=dependencies,
    packages=${FINDPKG}(
        where='.',
        include=['${PKG_NAMESPACE}'],$(echo -e "${FINDPKG_EXCLUDE}")
    ),
    # TODO: entrypoints
    # TODO: classifiers
)" > ${WORKINGCOPY_PATH}/setup.py
