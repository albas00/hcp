
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
readonly HEADER1="Authorization: HCP aGRz:f37535ae355ecd5ae00909e40233a433" 
readonly HEADER2="Accept: application/json"
readonly URL="https://admin.hdi.besthcp.cloud.corp:9090/mapi/tenants/"
readonly DIR="/storage/scripts/hcp/curl/"

storage_capacity_used ()
{
  local RESULT=$(curl -s -k -i -H "${HEADER1}" -H "${HEADER2}" "$URL$1/statistics?prettyprint=y" \
  | grep -i -e 'storageCapacityUsed' \
  | sed -e 's/[",]//g' \
  | awk -F\: {' print $2 '}) 
  echo $(( $RESULT / 1073741824 ))
}	# ----------  end of function storageCapacityUsed  ----------


tenants_details ()
{
  local RESULT=$(curl -s -k -i -H "${HEADER1}" -H "${HEADER2}" $URL$1/?prettyprint=y \
    | sed -e 's/[{"}",]//g' \
    | grep -i -e hardQuota \
    | awk -F\: '{ print $2 }' \
    | awk '{ print $1 }' \
    | awk -F\. '{print $1 }')  


  local RTN=$?
  if [[ $RTN -eq 0 ]] ; then
      # echo $("scale=2; $result * 1024" | bc)
      echo $((x=$RESULT * 1024))
  else
      echo 'N/A'
  fi


}	# ----------  end of function tenantsdetail  ----------



#printf "%-10s %-5s %-20s %-15s %-15s %s\n" "Dia" "Hora" "Name" "Quota (GB)" "Used (GB)" "Available (GB)" > $DIR"hcp_consumo.txt"

		DIA=$(date +%Y)"-"$(date +%m)"-"$(date +%d)
		HORA=$(date +%H)":"$(date +%M)

		RESULT=$(curl -s -k -i -H "$HEADER1" -H "$HEADER2" "$URL?sortType=name&sortOrder=ascending" \
  			| grep -i -e name \
  			| sed -e 's/[\[{"}]//g' \
  			| sed 's/\]//g' \
  			| awk -F\: '{ print $2 }')

  		rm $DIR"hcp_este_consumo.csv"

		IFS=',' read -r -a HDIS <<< $RESULT

		for HDI in ${HDIS} ; do
  			HARDQUOTA=$(tenants_details $HDI)
  			USEDSPACE=$(storage_capacity_used $HDI)
  			(( AVAILABLE=$HARDQUOTA - $USEDSPACE ))

  			printf "%-10s %-5s %-20s %-15s %-15s %s\n" "$DIA" "$HORA" "$HDI"_ESTE "$HARDQUOTA" "$USEDSPACE" "$AVAILABLE" >> $DIR"hcp_este_consumo.txt" 
			echo $DIA" "$HORA","$HDI"_ESTE,"$HARDQUOTA","$USEDSPACE >> $DIR"hcp_este_consumo.csv"

		done
		#echo "Se adjunta fichero de Consumo en HCP" | mailx -a $DIR"hcp_consumo.txt" -r gsys.storage@produban.com -s "Consumo HCP's" DLGSysOperationsStorage@produban.com
        

