#!/bin/bash

HOME_PATH=$1

MACHINE=pixi-cdl100
DISTRO=ces-fb
source ./setup-environment build/ | echo 'y'
cd ${HOME_PATH}/ces-bsp-platform/build
touch ${HOME_PATH}/ces-bsp-platform/build/conf/sanity.conf
${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake -D -v ces-qt-demoimage
