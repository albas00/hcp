#!/bin/bash
clear
DIR="/storage/scripts/hcp/curl/"
while true
do
	rm nohup.out
	rm ctera.cap
        hora=$(date +%H)
        minu=$(date +%M)

#        if [ $hora -eq 9 ] && [ $minu -eq 32 ]
        if [ $minu -eq 38 ]
           then 
echo "start"
			/storage/scripts/hcp/curl/ctera.sh >> ctera.cap
echo "end"
        fi
        
        
sleep 60
done
exit 0


