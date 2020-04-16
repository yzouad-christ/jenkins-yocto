#!/bin/bash

WORKSPACE_PATH=$1
BRANCH=$2


mkdir $WORKSPACE_PATH/ces-bsp-platform
cd $WORKSPACE_PATH/ces-bsp-platform

$WORKSPACE_PATH/bin/repo init -u https://github.com/software-celo/ces-bsp-platform -b $BRANCH
$WORKSPACE_PATH/bin/repo sync
