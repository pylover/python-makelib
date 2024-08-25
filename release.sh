#! /usr/bin/env bash
set -e


PRJROOT=$1
PKG_NAMESPACE=$2
PKG_VERSION=$3


# Exract the version from __init__.py if not given
if [ -z "${PKG_VERSION}" ];
  PKG_DIR=${PRJROOT}/$(sed 's|\.|/|g' <<< "${PKG_NAMESPACE}")
  PKG_FILE=${PKG_DIR}/__init__.py
  PKG_VERSION=$(grep '^__version__ = ' $PKG_FILE | cut -d'=' -f2 | xargs)
fi


GIT="git -C ${PRJROOT}"
TAG="v${PKG_VERSION}"


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
TAG_PATTERN=$(sed 's|\.|\\.|g' <<< "${TAG}")
if [[ -n $(${GIT} tag | grep ${TAG_PATTERN}) ]]; then
  echo "ERROR: Tag ${TAG} already exists." >&2
  exit 1
fi

# Create a git tag
${GIT} tag "v${PKG_VERSION}"


# Push code and tags
${GIT} push origin master --tags
