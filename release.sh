#! /usr/bin/env bash

set -e


PRJROOT=$1
PKG_NAMESPACE=$2
PKG_DIR=${PRJROOT}/$(sed 's|\.|/|g' <<< "${PKG_NAMESPACE}")
PKG_FILE=${PKG_DIR}/__init__.py
PKG_VER=$(grep '^__version__ = ' $PKG_FILE | cut -d'=' -f2 | xargs)


GIT="git -C ${PRJROOT}"
TAG="v${PKG_VER}"
TAG_PAT=$(sed 's|\.|\\.|g' <<< "${TAG}")


# Commit
if [[ -n $(${GIT} status -s) ]]; then
  if [[ -n $(${GIT} status -s | grep '^ m') ]]; then
    echo "ERROR: Modified submodule content. first commit it, then rerun." >&2
    exit 1
  fi

  ${GIT} add .
  ${GIT} commit -m"${TAG}"
fi
  

# Tag
if [[ -n $(${GIT} tag | grep ${TAG_PAT}) ]]; then
  echo "ERROR: Tag ${TAG} already exists." >&2
  exit 1
fi

# Create a git tag
${GIT} tag "v${PKG_VER}"


# Push code and tags
${GIT} push origin master --tags
