#!/bin/sh

VERSION=$(date +"%Y%m%d01")

BASE_DIR=~/deploy/${VERSION}

if [ -d "${BASE_DIR}" ]
then
   echo "${BASE_DIR} already exists. Is it your first deployment today? Please check!"
   exit
fi

LOG_BACKUP_DIR=~/backup/${VERSION}/logs

# ----------------
# Backup log files
# ----------------

echo "Backup log files"

mkdir -p ${LOG_BACKUP_DIR}/cms
find /usr/local/tomcat/actual/instances/cms/logs/ -type f -exec mv {} ${LOG_BACKUP_DIR}/cms \;
cd ${LOG_BACKUP_DIR}
tar -czf cms_${VERSION}.tgz cms
rm -rf cms

mkdir -p ${LOG_BACKUP_DIR}/engine
find /usr/local/tomcat/actual/instances/engine/logs/ -type f -exec mv {} ${LOG_BACKUP_DIR}/engine \;
cd ${LOG_BACKUP_DIR}
tar -czf engine_${VERSION}.tgz engine
rm -rf engine

echo "Done"
