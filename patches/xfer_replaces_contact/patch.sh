#!/bin/bash -e

. ../../config.conf

PJPROJECT_BASE_FOLDER="$DOWNLOAD_DIR/$PJSIP_DIR_NAME"

cp xfer_replaces_contact.patch $PJPROJECT_BASE_FOLDER

CURDIR=$(pwd)
cd "$PJPROJECT_BASE_FOLDER"
git apply --check xfer_replaces_contact.patch || exit 1
git apply --verbose xfer_replaces_contact.patch
rm xfer_replaces_contact.patch

cd "$CURDIR"
