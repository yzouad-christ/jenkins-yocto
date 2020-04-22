#!/bin/bash

HOME_PATH=$1

if [ ! -d "${HOME_PATH}/bin" ]
  mkdir ${HOME_PATH}/bin
  curl ${REPO_SOURCE} > ${HOME_PATH}/bin/repo
  chmod a+x ${HOME_PATH}/bin/repo
fi
