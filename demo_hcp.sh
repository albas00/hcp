#!/bin/bash
TOKEN="aGRz:f37535ae355ecd5ae00909e40233a433"

curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.besthcp.cloud.corp:9090/mapi/tenants/CTERA/namespaces/UCLOUD/statistics?prettyprint"
#curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: application/json" "https://admin.hdi.bosthcp.cloud.corp:9090/mapi/tenants"

#curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: text/csv" "https://admin.cslhcpnp00.unix.aacc.corp:9090/mapi/tenants/hdi/chargebackReport"
#curl -X GET -k -H "Authorization: HCP ${TOKEN}" -H "Accept: text/csv" "https://admin.cslhcpsp00.unix.aacc.corp:9090/mapi/tenants/hdi/chargebackReport?prettyprint"

