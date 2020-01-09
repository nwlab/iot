#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

cp ${BR2_EXTERNAL}/board/${BOARD_NAME}/config.txt ${BINARIES_DIR}/config.txt
cp ${BR2_EXTERNAL}/board/${BOARD_NAME}/cmdline.txt ${BINARIES_DIR}/cmdline.txt

cp ${BINARIES_DIR}/zImage ${BINARIES_DIR}/kernel7.img
cp ${BINARIES_DIR}/zImage ${BINARIES_DIR}/kernel.img

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
