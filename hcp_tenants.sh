#!/bin/bash
clear
DIR="/storage/scripts/hcp/curl/"

        TOKEN="aGRz:f37535ae355ecd5ae00909e40233a433"

        printf "%s\n" "========================================" > $DIR"hcp_tenants.txt"
        printf "%s\n" "==            HCP TENANTS             ==" >> $DIR"hcp_tenants.txt"
        printf "%s\n" "========================================" >> $DIR"hcp_tenants.txt"
        printf "%s\n" " " >> $DIR"hcp_tenants.txt"
        printf "%-14s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s\n" "FECHA-HORA" "BOADILLA" "BOA_NEW" "CTERA" "EV_CAN" "HDI01" "HDI02" "HDI03" "HDI04" "HDI05" "HDI06" "HDI07" >> $DIR"hcp_tenants.txt"
        printf "%s %s %s %s %s %s %s %s %s %s %s %s\n" "==============" "==========" "==========" "==========" "==========" "==========" "==========" "==========" "==========" "==========" "==========" "==========" >> $DIR"hcp_tenants.txt"
        printf "%s %s %s %s %s\n" "==============" "==========" "==========" "==========" "==========" >> $DIR"hcp_oeste_tenants.txt"

		FECHA=$(date +%Y)$(date +%m)$(date +%d)"-"$(date +%H)":"$(date +%M)
		#echo $FECHA
		boa=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/boadilla/statistics?prettyprint" |grep "storageCapacityUsed"  |awk -F, '{print $1}' |awk '{print $3}'`
                bnew=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/boadillanew/statistics?prettyprint" |grep "storageCapacityUsed"  |awk -F, '{print $1}' |awk '{print $3}'`
                ctera=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/CTERA/statistics?prettyprint" |grep "storageCapacityUsed"  |awk -F, '{print $1}' |awk '{print $3}'`
                evcan=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/evcantabria/statistics?prettyprint" |grep "storageCapacityUsed"  |awk -F, '{print $1}' |awk '{print $3}'`
                hdi1=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/vmnxbhdistt01/statistics?prettyprint" |grep "storageCapacityUsed" |awk -F, '{print $1}' |awk '{print $3}'`
                hdi2=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/vmnxbhdistt02/statistics?prettyprint" |grep "storageCapacityUsed" |awk -F, '{print $1}' |awk '{print $3}'`
		hdi3=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/vmnxbhdistp03/statistics?prettyprint" |grep "storageCapacityUsed" |awk -F, '{print $1}' |awk '{print $3}'`
                hdi4=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/vmnxbhdistp04/statistics?prettyprint" |grep "storageCapacityUsed" |awk -F, '{print $1}' |awk '{print $3}'`
		hdi5=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/vmnxbhdistp05/statistics?prettyprint" |grep "storageCapacityUsed" |awk -F, '{print $1}' |awk '{print $3}'`
                hdi6=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/vmnxbhdistp06/statistics?prettyprint" |grep "storageCapacityUsed" |awk -F, '{print $1}' |awk '{print $3}'`
		hdi7=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/vmnxbhdistp07/statistics?prettyprint" |grep "storageCapacityUsed" |awk -F, '{print $1}' |awk '{print $3}'`

                bo=`echo "scale=2; ($boa/1024/1024/1024)" |bc -l`
                bn=`echo "scale=2; ($bnew/1024/1024/1024)" |bc -l`
                ct=`echo "scale=2; ($ctera/1024/1024/1024)" |bc -l`
                ev=`echo "scale=2; ($evcan/1024/1024/1024)" |bc -l`
                h1=`echo "scale=2; ($hdi1/1024/1024/1024)" |bc -l`
                h2=`echo "scale=2; ($hdi2/1024/1024/1024)" |bc -l`
                h3=`echo "scale=2; ($hdi3/1024/1024/1024)" |bc -l`
                h4=`echo "scale=2; ($hdi4/1024/1024/1024)" |bc -l`
		h5=`echo "scale=2; ($hdi5/1024/1024/1024)" |bc -l`
		h6=`echo "scale=2; ($hdi6/1024/1024/1024)" |bc -l`
		h7=`echo "scale=2; ($hdi7/1024/1024/1024)" |bc -l`
	
		echo $FECHA" "$bo" "$bn" "$ct" "$ev" "$h1" "$h2" "$h3" "$h4" "$h5" "$h6" "$h7 >$DIR"tempo"

		awk '{printf("%-14s %10.2f %10.2f %10.2f %10.2f %10.2f %10.2f %10.2f %10.2f %10.2f %10.2f %10.2f\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)}'  $DIR"tempo" >> $DIR"hcp_tenants.txt"


