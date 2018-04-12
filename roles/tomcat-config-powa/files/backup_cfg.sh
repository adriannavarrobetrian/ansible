#!/bin/sh

VERSION=$(date +"%Y%m%d01")

BASE_DIR=~/backup/${VERSION}
CFG_BACKUP_DIR=${BASE_DIR}/cfg

if [ -d "${CFG_BACKUP_DIR}" ]
then
   echo "${CFG_BACKUP_DIR} already exists. Is it your first deployment today? Please check."
   exit
fi

mkdir -p ${CFG_BACKUP_DIR}

echo -n "Backing up admin"
tar -czf ${CFG_BACKUP_DIR}/admin.tgz \
/tomcat/admin/WEB-INF/classes/{admin-configuration,admin-run-profile.properties}

echo -n "Backing up api"
tar -czf ${CFG_BACKUP_DIR}/api.tgz \
/tomcat/api/WEB-INF/classes/{api-configuration,api-run-profile.properties}

echo -n "Backing up rest"
tar -czf ${CFG_BACKUP_DIR}/rest.tgz \
/tomcat/rest/WEB-INF/classes/{rest-api-configuration,rest-api-run-profile.properties}

echo -n "Backing up cms"
tar -czf ${CFG_BACKUP_DIR}/cms.tgz \
/tomcat/cms/WEB-INF/classes/{cms-configuration,cms-run-profile.properties,host.properties}

echo -n "Backing up engine"
tar -czf ${CFG_BACKUP_DIR}/engine.tgz \
/tomcat/engine/WEB-INF/classes/{engine-configuration,engine-run-profile.properties}

echo -n "Backing up file"
tar -czf ${CFG_BACKUP_DIR}/file.tgz \
/tomcat/file/WEB-INF/classes/{file-configuration,file-run-profile.properties}

echo -n "Backing up gbase"
tar -czf ${CFG_BACKUP_DIR}/gbase.tgz \
/tomcat/gbase/WEB-INF/classes/{googleapi-configuration,gbase-run-profile.properties}

echo -n "Backing up template"
tar -czf ${CFG_BACKUP_DIR}/template.tgz \
/tomcat/template/WEB-INF/classes/{template-configuration,template-run-profile.properties}
