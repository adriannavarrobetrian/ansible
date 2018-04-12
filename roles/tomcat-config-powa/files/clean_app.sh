#!/bin/sh

VERSION=$(date +"%Y%m%d01")

# Before doing anything else, let's check that there are backups
CFG_BACKUP_DIR=~/backup/${VERSION}/cfg
if [ ! -d "${CFG_BACKUP_DIR}" ]
then
   echo "${CFG_BACKUP_DIR}: backup dir not found. Aborting."
   exit 1
fi
for item in admin api cms engine file gbase template
do
   echo -n "Looking for $item backup... "
   if [ ! -f ${CFG_BACKUP_DIR}/${item}.tgz ]
   then
      echo "No backup found for ${item}. Aborting."
      exit 1
   fi
   if [ $(stat -c%s ${CFG_BACKUP_DIR}/${item}.tgz) -eq 0 ]
   then
      echo "${item} has 0-byte size. Aborting."
      exit 1
   fi
   echo "ok."
done

BASE_DIR=~/deploy/${VERSION}
LOG_BACKUP_DIR=~/backup/${VERSION}/logs

# --------------------------
# Backup configuration files
# --------------------------

mkdir -p ${BASE_DIR}

echo "Clean CMS files"

rm -rvf /tomcat/cms/WEB-INF/classes/*
rm -rvf /tomcat/cms/WEB-INF/deploy/*
rm -rvf /tomcat/cms/WEB-INF/email/*
rm -rvf /tomcat/cms/WEB-INF/lib/*
rm -rvf /tomcat/cms/WEB-INF/freemarker/*
rm -vf  /tomcat/cms/WEB-INF/*

rm -rvf /tomcat/cms/ControlPanel/*
rm -rvf /tomcat/cms/flash/*
rm -rvf /tomcat/cms/ckeditor/*
rm -rvf /tomcat/cms/secure/*
rm -rvf /tomcat/cms/resource/common/*
rm -rvf /tomcat/cms/images/*
rm -vf  /tomcat/cms/*

echo "Clean Engine files"

rm -rvf /tomcat/engine/WEB-INF/classes/*
rm -rvf /tomcat/engine/WEB-INF/email/* 
rm -rvf /tomcat/engine/WEB-INF/lib/*
rm -rvf /tomcat/engine/WEB-INF/dynamic-css/*
rm -vf  /tomcat/engine/WEB-INF/*

rm -rvf /tomcat/engine/resource/common/*
rm -vf  /tomcat/engine/*

echo "Clean Template files"

rm -rvf /tomcat/template/WEB-INF/classes/*
rm -rvf /tomcat/template/WEB-INF/lib/*
# Delete all templates except "runtime" and "vendors"
for i in `ls /tomcat/template/WEB-INF/template/ | egrep -v "runtime|vendors"`
do
    rm -rvf '/tomcat/template/WEB-INF/template/'$i
done
rm -vf /tomcat/template/WEB-INF/*
rm -vf /tomcat/template/*

echo "Clean Admin files"

rm -rvf /tomcat/admin/WEB-INF/classes/*
rm -rvf /tomcat/admin/WEB-INF/lib/*
rm -vf  /tomcat/admin/WEB-INF/*
rm -rvf /tomcat/admin/AdminConsole/*
rm -vf  /tomcat/admin/*

echo "Clean API files"

rm -rvf /tomcat/api/WEB-INF/classes/*
rm -rvf /tomcat/api/WEB-INF/lib/*
rm -vf  /tomcat/api/WEB-INF/*
rm -vf  /tomcat/api/*

echo "Clean File files"

rm -rvf /tomcat/file/WEB-INF/classes/*
rm -rvf /tomcat/file/WEB-INF/lib/*
rm -vf  /tomcat/file/WEB-INF/*
rm -vf  /tomcat/file/*

echo "Clean GBase files"

rm -rvf /tomcat/gbase/WEB-INF/classes/*
rm -rvf /tomcat/gbase/WEB-INF/lib/*
rm -vf  /tomcat/gbase/WEB-INF/*
rm -vf  /tomcat/gbase/*

echo "Done"
