#!/bin/bash -
#===============================================================================
#
#          FILE: lsnamespaces.sh
# 
#         USAGE: ./lsnamespaces.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/16/2017 17:10
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

readonly HEADER1="Authorization: HCP aGRz:f37535ae355ecd5ae00909e40233a433"
readonly HEADER2="Accept: application/json"
readonly URL="https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/"

get_namespace_statistics ()
{
  local tenant=$1
  local namespace=$2
  local result=$(curl -s -k -i -H "$HEADER1" -H "$HEADER2" "$URL$tenant/namespaces/$namespace/statistics?prettyprint=y" \
  | grep -i -e 'storageCapacity' -e 'compressedCount' \
  | sed -e 's/[",]//g')
  echo $result  
}	# ----------  end of function get_namespace_statistics  ----------


get_namespace_hardquota ()
{
  local tenant=$1
  local namespace=$2
  local result=$(curl -s -k -i -H "$HEADER1" -H "$HEADER2" "$URL$tenant/namespaces/$namespace?prettyprint=y" \
  | grep -i -e 'hardquota' \
  | sed -e 's/"//g' -e 's/,//g' \
  | awk -F\: '{ print $2 }')
  echo $result  
}	# ----------  end of function get_namespace_hardquota  ----------


get_namespaces ()
{
  declare -a namespaces
  local namespace
  local hardquota
  local tenant=$1
  local result=$(curl -s -k -i -H "$HEADER1" -H "$HEADER2" "$URL$tenant/namespaces?prettyprint=y" \
  | grep -i -e 'name'\
  | sed -e 's/[\[{,}"]//g' -e 's/\]//g' \
  | sed -e 's/name ://g' -e 's/system-install//g' -e 's/system-backup-data//g')

  IFS=' ' read -r -a namespaces <<< $result
  if [[ ${#namespaces[@]} -eq 0 ]] ; then
    echo 'N/A'
  else
    
    for namespace in "${namespaces[@]}" ; do
      hardquota=$(get_namespace_hardquota $tenant $namespace)
      statistics=$(get_namespace_statistics $tenant $namespace)
      printf "%-60s %-11s %s\n" "$namespace" "$hardquota" "$statistics"
    done
  fi
}	# ----------  end of function get_namespaces  ----------




RESULT=$(curl -s -k -i -H "$HEADER1" -H "$HEADER2" "$URL?sortType=name&sortOrder=ascending" \
  | grep -i -e 'name' \
  | sed -e 's/[{"\[}]//g' \
  | sed -e 's/\]//g' \
  | sed -e 's/name://g')

IFS=',' read -r -a HDIS <<< $RESULT

for line in `grep -v  "^#" /storage/scripts/hdi/hdi.txt | awk '{print $2}'`
        do
                HDI=`echo $line| awk '{print $1}'`

#for HDI in ${HDIS[@]}  ; do
  echo $HDI
  get_namespaces $HDI
  echo ''
done
