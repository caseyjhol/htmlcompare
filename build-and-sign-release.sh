#!/bin/sh

for D in build dist; do
    if [ -e "$D" ]; then
        trash "$D"
    fi
done

PROJECT_NAME=HTMLCompare
MOD_NAME="${PROJECT_NAME}"

/usr/bin/python3 setup.py sdist bdist_wheel > /dev/null

trash build

RELEASE_VERSION=$(cat VERSION.txt)

gpg --local-user="0x77E0DB66" --detach-sign  -a dist/${PROJECT_NAME}-${RELEASE_VERSION}*.tar.gz
gpg --local-user="0x77E0DB66" --detach-sign  -a dist/${MOD_NAME}-${RELEASE_VERSION}*.whl

RELEASE_FILES=$(ls -1 dist/${MOD_NAME}-${RELEASE_VERSION}*)

echo twine upload "dist/${PROJECT_NAME}-${RELEASE_VERSION}*" "dist/${MOD_NAME}-${RELEASE_VERSION}*"
