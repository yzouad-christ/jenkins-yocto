#!/bin/bash

HOME_PATH=$1
BRANCH=$2
GIT_URL=$3

if [ ! -d "${HOME_PATH}/ces-bsp-platform" ]; then
  mkdir $HOME_PATH/ces-bsp-platform
fi

cd $HOME_PATH/ces-bsp-platform

if [ ! "$(ls -A ${HOME_PATH}/ces-bsp-platform)" ]; then
  $HOME_PATH/bin/repo init -u $GIT_URL -b $BRANCH
fi
