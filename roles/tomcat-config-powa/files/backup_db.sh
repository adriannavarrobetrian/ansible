#!/bin/sh

VERSION=$(date +"%Y%m%d01")

BASE_DIR=~/backup/${VERSION}
DB_BACKUP_DIR=${BASE_DIR}/db

if [ -d "${DB_BACKUP_DIR}" ]
then
   echo "${DB_BACKUP_DIR} already exists. Is it your first deployment today? Please check."
   exit
fi

# ----------------
# Backup databases
# ----------------

echo "Backup databases"

mkdir ${DB_BACKUP_DIR}

mysqldump -h mysql-01.test.glp --databases cms -u cms -p'#cmsdbpass' -r ${DB_BACKUP_DIR}/cms_${VERSION}.dmp
gzip ${DB_BACKUP_DIR}/cms_${VERSION}.dmp

mysqldump -h mysql-01.test.glp --databases engine -u engine -p'#enginedbpass' -r ${DB_BACKUP_DIR}/engine_${VERSION}.dmp
gzip ${DB_BACKUP_DIR}/engine_${VERSION}.dmp

mysqldump -h mysql-01.test.glp --databases admin -u admin -p'#admindbpass' -r ${DB_BACKUP_DIR}/admin_${VERSION}.dmp
gzip ${DB_BACKUP_DIR}/admin_${VERSION}.dmp

mysqldump -h mysql-01.test.glp --databases api -u api -p'#apidbpass' -r ${DB_BACKUP_DIR}/api_${VERSION}.dmp
gzip ${DB_BACKUP_DIR}/api_${VERSION}.dmp

mysqldump -h mysql-01.test.glp --databases file -u file -p'#filedbpass' -r ${DB_BACKUP_DIR}/file_${VERSION}.dmp
gzip ${DB_BACKUP_DIR}/file_${VERSION}.dmp

mysqldump -h mysql-01.test.glp --databases gbase -u gbase -p'#gbasedbpass' -r ${DB_BACKUP_DIR}/gbase_${VERSION}.dmp
gzip ${DB_BACKUP_DIR}/gbase_${VERSION}.dmp
