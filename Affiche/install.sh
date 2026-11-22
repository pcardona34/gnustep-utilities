#!/bin/bash

####################################################
### AGNoStep gnustep-recommended
### (c) 2026 Patrick Cardona
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Install Affiche
################################

################################
### VARS
SPIN='/-\|'
FIND="YES"
SCRIPTS=../../../SCRIPTS

if [ ! -d ${SCRIPTS} ];then
    echo -e "Bad path: main SCRIPTS folder was not found.\n"
    exit 1
fi

################################
### You must be superuser to install
sudo -v

### Dependencies
#################################
. ./DEPS.ini
if [ "$RENAISSANCE" == "YES" ];then
    check_renaissance
fi

if [ -n "${DEBS}" ];then
    install_deps ${DEBS}
fi

sleep 2;clear

### Setting quilt patch tool
set_quilt

### Build and Install the GNUstep app
clear

echo -e "\nDebug status: $DEBUG"
sleep 1

STR="Purge old release";
subtitulo

pushd . >/dev/null
remove_ifx_app ${APPNAME}
popd >/dev/null
stop

sleep 2
clear
STR="Building and installing ${APP}"
subtitulo

pushd . >/dev/null
cd build/${REPO} || exit 1

printf "Patching with quilt...\n"
quilt push -a

_build || exit 1
popd >/dev/null
stop

info "All was done for ${APPNAME}."
sleep 2
stop
