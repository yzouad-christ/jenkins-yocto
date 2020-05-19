#!/bin/bash

HOME_PATH=$1
TOOLCHAIN_ARG=$2

cd ${HOME_PATH}/ces-bsp-platform


if [ ! -z $IMAGE_ARG ]; then
  IMAGE=${IMAGE_ARG}
else
  IMAGE="meta-toolchain-qt5"
fi

# source setup-environment
source ./setup-environment build/ | echo 'y'

# Accept FSL_EULA
echo "ACCEPT_FSL_EULA = \"1\"" >> ${HOME_PATH}/ces-bsp-platform/build/conf/local.conf

# Expand PATH variable
PATH=/home/jenkins/ces-bsp-platform/sources/poky/scripts:/home/jenkins/ces-bsp-platform/sources/poky/bitbake/bin:${PATH}

cd ${HOME_PATH}/ces-bsp-platform/build

# Build image
if [ -z $DEBUG ]; then
  ${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake ${IMAGE}
else
  ${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake -D -v ${IMAGE}
fi
