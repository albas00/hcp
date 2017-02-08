

TOKEN="aGRz:f37535ae355ecd5ae00909e40233a433"

ctera=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/CTERA/statistics?prettyprint" |grep "objectCount" |awk '{print $3}'`
sanhq=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/CTERA/namespaces/SANHQ/statistics?prettyprint" |grep objectCount |awk '{print $3}'`
scgbn=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/CTERA/namespaces/SCGBN/statistics?prettyprint" |grep objectCount |awk '{print $3}'`
ucloud=`curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants/CTERA/namespaces/UCLOUD/statistics?prettyprint" |grep objectCount |awk '{print $3}'`

echo "CTERA...................: "$ctera
echo "SANHQ...................: "$sanhq
echo "SCGBN...................: "$scgbn
echo "UCLOUD..................: "$ucloud




