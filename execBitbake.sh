#!/bin/bash

HOME_PATH=$1
MACHINE_ARG=$2
DISTRO_ARG=$3
IMAGE_ARG=$4
BRANCH_ARG=$5

#Supported devices:
declare -a DEV_LIST=("pixi-cdl200" "pixi-cq100" "pixi-cq200" "crix-cq100" "crix-arq100" "blix-bdl100" "blix-bq100" "4cbox-cdl100" "4cbox-cdl200" "4cbox-cq100" "4cbox-cq200")
#Supported distributions:
declare -a DIST_LIST=("ces-fb" "ces-x11")

cd ${HOME_PATH}/ces-bsp-platform

# checkout branch in meta-customer
if [ ! -z $BRANCH_ARG  ]; then
  BRANCH=$BRANCH_ARG
  cd sources/meta-customer
  git checkout $BRANCH
  cd ${HOME_PATH}/ces-bsp-platform
fi

# check if arguments are set
DEFAULT=0
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

# set default mode if DEFAULT variable is set
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

cd ${HOME_PATH}/ces-bsp-platform/build

# copy new bblayer.conf if customer image has to be build
if [ ! -z BRANCH_ARG ]; then
  cp ${HOME_PATH}/bblayers.conf ${HOME_PATH}/ces-bsp-platform/build/conf
fi

# Accept FSL_EULA
echo "ACCEPT_FSL_EULA = \"1\"" >> ${HOME_PATH}/ces-bsp-platform/build/conf/local.conf

# Expand PATH variable
PATH=/home/jenkins/ces-bsp-platform/sources/poky/scripts:/home/jenkins/ces-bsp-platform/sources/poky/bitbake/bin:${PATH}

# Build image
if [ -z $DEBUG ]; then
  ${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake ${IMAGE}
else
  ${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake -D -v ${IMAGE}
fi
