#! /bin/bash
CONTAINER_VER="1.0"
PRODUCT_NAME="genie-software"
SWUPDATE_FILES_PATH="$(dirname $0)"
FILES="sw-description sw-description.sig"

# Add hash in sw-description. 
compute_hash(){
  names=$(cat "${SWUPDATE_FILES_PATH}/sw-description" | sed -n '/@/p' | cut -d@ -f2 | uniq )
  cp ${SWUPDATE_FILES_PATH}/sw-description ${BINARIES_DIR}/sw-description ;
  for name in $names;do
     FILES+=" $name";
     sha256=$(sha256sum "${BINARIES_DIR}/$name" | cut -d ' ' -f1 )
     sed -i "s/@$name/\"$sha256\";/"  "${BINARIES_DIR}/sw-description" ; 
  done ;
}

# Create sw-description.sig. A private key is needed
create_swdescription_sig(){
  if test -f "${SWUPDATE_FILES_PATH}/swupdate-priv.pem"
  then
    openssl dgst -sha256 -sign "${SWUPDATE_FILES_PATH}/swupdate-priv.pem" "${BINARIES_DIR}/sw-description" > "${BINARIES_DIR}/sw-description.sig"
  else
    echo "Private key doesn't exist"
    exit 1
  fi
}

# Create .swu archive 
create_swu(){
  cd ${BINARIES_DIR}
  for i in $FILES;do
        echo $i;done | cpio -ov -H crc >  ${PRODUCT_NAME}_${CONTAINER_VER}.swu
}

compute_hash
create_swdescription_sig
create_swu

exit 0