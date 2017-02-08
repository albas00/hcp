#!/bin/bash -
#===============================================================================
#
#          FILE: lstenants.sh
#
#         USAGE: ./lstenants.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 01/11/2017 10:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
readonly DIR="/storage/scripts/hcp/curl/"
/storage/scripts/hcp/curl/lstenants_este.sh
/storage/scripts/hcp/curl/lstenants_oeste.sh
sleep 5
rm $DIR"hcp_consumo.csv"
cat $DIR"hcp_oeste_consumo.csv" > $DIR"hcp_consumo.csv"
cat $DIR"hcp_este_consumo.csv" >> $DIR"hcp_consumo.csv"

exit 0


