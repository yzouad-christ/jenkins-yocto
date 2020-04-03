
#!/bin/bash

#Supported devices:
declare -a DEV_LIST=("pixi-cdl200" "pixi-cq100" "pixi-cq200" "crix-cq100" "crix-arq100" "blix-bdl100" "blix-bq100" "4cbox-cdl100" "4cbox-cdl200" "4cbox-cq100" "4cbox-cq200")
declare -a DIST_LIST=("ces-fb" "ces-x11")
DEVICE=$1
DIST=$2

if [ ! -z $DEVICE ]; then
        if [[ " ${DEV_LIST[@]} " =~ " ${DEVICE} " ]]; then
                if [[ " ${DIST_LIST[@]} " =~ " ${DIST} " ]]; then
                        MACHINE=${DEVICE} DISTRO=${DIST} source ./setup-environment build
                        echo "MACHINE=$MACHINE"
                        echo "DISTRO=$DISTRO"
                        exit 0
                else
                        echo "ERROR: Distribution is not supported!"
                fi
        else
                echo "ERROR: Device is not supported!"
        fi
else
        echo "ERROR: Missing argument!"
fi

exit 1

