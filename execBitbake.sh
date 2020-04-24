#!/bin/bash

# Switch to jenkins user
su jenkins

HOME_PATH=$1
MACHINE_ARG=$2
DISTRO_ARG=$3
IMAGE_ARG=$4

#Supported devices:
declare -a DEV_LIST=("pixi-cdl200" "pixi-cq100" "pixi-cq200" "crix-cq100" "crix-arq100" "blix-bdl100" "blix-bq100" "4cbox-cdl100" "4cbox-cdl200" "4cbox-cq100" "4cbox-cq200")
#Supported distributions:
declare -a DIST_LIST=("ces-fb" "ces-x11")

cd ${HOME_PATH}/ces-bsp-platform

if [ ! -z $MACHINE_ARG ]; then
  MACHINE=${MACHINE_ARG}
else
  DEFAULT=1
fi

if [ ! -z $DISTRO_ARG ]; then
  DISTRO=${DISTRO_ARG}
else
  DEFAULT=1
fi
if [ ! -z $IMAGE_ARG ]; then
  IMAGE=${IMAGE_ARG}
else
  DEFAULT=1
fi

if [ $DEFAULT -eq 1 ]; then
  echo "WARNING: Build configurations not set"
  echo "WARNING: Setting default configuration"
  echo "DEBUG: Setting debug mode"
  DEBUG=1
  MACHINE=pixi-cdl100
  DISTRO=ces-fb
  IMAGE="ces-qt-demoimage"
fi

# source setup-environment
source ./setup-environment build/ | echo 'y'

whoami
printenv
exit 1

# Create sanity.conf to be able to build as root
cd ${HOME_PATH}/ces-bsp-platform/build
touch ${HOME_PATH}/ces-bsp-platform/build/conf/sanity.conf

# Accept FSL_EULA
echo "ACCEPT_FSL_EULA = \"1\"" >> ${HOME_PATH}/ces-bsp-platform/build/conf/local.conf

# Set this variable to build as root
FORCE_UNSAFE_CONFIGURE=1

# Expand PATH variable
PATH=/home/jenkins/ces-bsp-platform/sources/poky/scripts:/home/jenkins/ces-bsp-platform/sources/poky/bitbake/bin:${PATH}

# Build image
if [ -z $DEBUG ]; then
  ${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake ${IMAGE}
else
  ${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake -D -v ${IMAGE}
fi
