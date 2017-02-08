#!/bin/bash
clear
DIR="/storage/scripts/hcp/curl/"
	rm nohup.out
        hora=$(date +%H)
        minu=$(date +%M)

		/home/storage/bin/cifs_quota > /dev/null
		sleep 3

                li=`cat $DIR"cuotas_cifs_ggss.txt" |wc -l`

                if [ $li -gt 0 ]
                        then

                                echo "Se adjunta fichero con la cuota superada" | mailx -a cuotas_cifs_ggss.txt -r gsys.storage@produban.com -s "Namespaces con espacio mayor de 85 de quota" DLGSysOperationsStorage@produban.com, jorge.moriano@produban.com
                fi
exit 0


