#!/bin/bash

#Image name that has to be built
IMAGE_NAME=$1

if [ ! -z $IMAGE ]; then
        bitbake $IMAGE_NAME
        exit $?
else
        echo "ERROR: Missing argument!"
        exit 1
fi
