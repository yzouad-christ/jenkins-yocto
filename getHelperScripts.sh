#!/bin/bash

PATH_TO_REPO="/home/jenkins/jenkins-repo/jenkins-yocto"

if [ ! -d $PATH_TO_REPO ]; then
	git clone https://github.com/yzouad-christ/jenkins-yocto.git
else
	git reset --hard HEAD
	git pull --rebase origin master
fi

chmod -R 755 jenkins-yocto
