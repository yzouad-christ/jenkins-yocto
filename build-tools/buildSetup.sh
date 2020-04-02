#!/bin/bash

#Supported devices:
declare -a DEV_LIST=("pixi-cdl200" "pixi-cq100" "pixi-cq200" "crix-cq100" "crix-arq100" "blix-bdl100" "blix-bq100" "4cbox-cdl100" "4cbox-cdl200" "4cbox-cq100" "4cbox-cq200")
DEVICE=$1

if [ ! -z $DEVICE ]; then
        for SUPPORTED_DEV in "${DEV_LIST[@]}"
        do
                if [ $DEVICE = $SUPPORTED_DEV ]; then
                        MACHINE=${DEVICE} DISTRO=ces-fb source ./setup-environment build
                        echo "MACHINE=$MACHINE"
                        echo "DISTRO=$DISTRO"
                        exit 0
                fi
        done
        echo "ERROR: Device is not supported!"
else
        echo "ERROR: Missing argument!"
fi

exit 1
