#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

cp callid.patch $PJPROJECT_BASE_FOLDER

CURDIR=$(pwd)
cd "$PJPROJECT_BASE_FOLDER"
patch -p0 < callid.patch
rm callid.patch

cd "$CURDIR"
