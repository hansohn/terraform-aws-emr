#!/usr/bin/env bash

set -ex

#------------------------------------------------------------------------------
# FUNCTIONS
#------------------------------------------------------------------------------

function is_master {
    grep isMaster /mnt/var/lib/info/instance.json | grep true
}

#------------------------------------------------------------------------------
# VARIABLES
#------------------------------------------------------------------------------

HOME_HADOOP="/home/hadoop"

#------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------

# config awscli
echo "region = ${aws_region}" >> $${HOME_HADOOP}/.aws/config

# set naming convention env vars
echo "NC_DELIMITER=${delimiter}" | sudo tee --append /etc/environment
echo "NC_ENVIRONMENT=${environment}" | sudo tee --append /etc/environment
echo "NC_NAMESPACE=${namespace}" | sudo tee --append /etc/environment
echo "NC_STAGE=${stage}" | sudo tee --append /etc/environment

# set aws env vars
echo "AWS_ACCOUNT=${aws_account_id}" | sudo tee --append /etc/environment
echo "AWS_REGION=${aws_region}" | sudo tee --append /etc/environment
