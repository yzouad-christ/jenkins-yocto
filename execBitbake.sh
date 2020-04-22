#!/bin/bash

HOME_PATH=$1

cd ${HOME_PATH}/ces-bsp-platform

MACHINE=pixi-cdl100
DISTRO=ces-fb
source ./setup-environment build/ | echo 'y'
cd ${HOME_PATH}/ces-bsp-platform/build
touch ${HOME_PATH}/ces-bsp-platform/build/conf/sanity.conf
PATH=/home/jenkins/ces-bsp-platform/sources/poky/scripts:/home/jenkins/ces-bsp-platform/sources/poky/bitbake/bin:${PATH}
${HOME_PATH}/ces-bsp-platform/sources/poky/bitbake/bin/bitbake -D -v ces-qt-demoimage
