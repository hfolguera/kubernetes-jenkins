#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf
DATE=`date +"%d%m%Y"`

DATE_BACKUP_FMT=`date +"%Y-%m-%d"`

TMP_PATH=/tmp/jenkins_backup_${DATE}
DEST_PATH=/nfs/homelab/backup/jenkins

echo "[INFO] Starting backup for Jenkins at $DATE"

NS=jenkins

POD=`kubectl get pod -n $NS -l app=jenkins-server -o jsonpath='{.items[0].metadata.name}'`
echo "[DEBUG] POD: $POD"

echo "[INFO] Executing backup for $DB"
mkdir ${TMP_PATH}
kubectl cp -n $NS ${POD}:/var/jenkins_home/backups ${TMP_PATH}/
if [ $? -ne 0 ]
then
    echo "[ERROR] Cannot copy files from POD ${POD}"
    RC=1
    exit $RC
else
    tar -czvf ${DEST_PATH}/jenkins_backup_${DATE}.tar.gz -C ${TMP_PATH} .
    if [ $? -ne 0 ]
    then
        echo "[ERROR] Cannot compress backup ${TMP_PATH}"
        RC=1
        exit $RC
    else
        rm -rf ${TMP_PATH}
    fi
fi

echo "[INFO] Backup finished"
echo "[INFO] Purging old backups"
#Purge old backups
find $DEST_PATH/*.tar.gz -mtime +7 -exec rm {} \;
echo "[INFO] End of script"
echo ""

exit $RC