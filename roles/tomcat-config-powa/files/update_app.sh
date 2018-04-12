#!/bin/sh

VERSION=$(date +"%Y%m%d01")

if [ -z "$1" ]
then
   echo "Please provide path to build package as argument."
   exit
fi

BASE_DIR=~/deploy/${VERSION}
BUILD_FILE_NAME=$(readlink -m "$1")

if [ ! -f "${BUILD_FILE_NAME}" ]
then
   echo "Build not found. Aborting."
   exit 1
fi

BACKUP_BASE_DIR=~/backup/${VERSION}
if [ ! -d "${BACKUP_BASE_DIR}" ]
then
   echo "No backup found! Something went wrong. Aborting."
   exit 1
fi

# -------------
# Extract build
# -------------

echo "Extract build"

mkdir -p ${BASE_DIR}
tar -xzf ${BUILD_FILE_NAME} -C ${BASE_DIR}
if [ $? -ne 0 ]
then
   echo "Untarring was not successful. Aborting"
   exit 1
fi

mkdir ${BASE_DIR}/cms
cd ${BASE_DIR}/cms/
unzip -o ../cms-*.war > unzip_cms.log
rm -f ../cms-*.war
mkdir ${BASE_DIR}/engine
cd ${BASE_DIR}/engine/
unzip -o ../engine-*.war > unzip_engine.log
rm -f ../engine-*.war
mkdir ${BASE_DIR}/template
cd ${BASE_DIR}/template/
unzip -o ../template-*.war > unzip_template.log
rm -f ../template-*.war
mkdir ${BASE_DIR}/admin
cd ${BASE_DIR}/admin/
unzip -o ../admin-*.war > unzip_admin.log
rm -f ../admin-*.war
mkdir ${BASE_DIR}/api
cd ${BASE_DIR}/api/
unzip -o ../api-*.war > unzip_api.log
rm -f ../api-*.war
mkdir ${BASE_DIR}/file
cd ${BASE_DIR}/file/
unzip -o ../file-*.war > unzip_file.log
rm -f ../file-*.war
mkdir ${BASE_DIR}/gbase
cd ${BASE_DIR}/gbase/
unzip -o ../gbase-*.war > unzip_gbase.log
rm -f ../gbase-*.war
mkdir ${BASE_DIR}/rest
cd ${BASE_DIR}/rest/
unzip -o ../rest-*.war > unzip_rest.log
rm -f ../rest-*.war

# ----------------
# Update CMS files
# ----------------

echo "Update CMS files"

cd ${BASE_DIR}/

cp -R cms/WEB-INF/classes/*  		/tomcat/cms/WEB-INF/classes/
cp -R cms/WEB-INF/deploy/*  		/tomcat/cms/WEB-INF/deploy/
cp -R cms/WEB-INF/email/*    		/tomcat/cms/WEB-INF/email/
cp -R cms/WEB-INF/lib/*      		/tomcat/cms/WEB-INF/lib/
cp -R cms/WEB-INF/freemarker/*   /tomcat/cms/WEB-INF/freemarker/
cp    cms/WEB-INF/*          		/tomcat/cms/WEB-INF/

mkdir -p /tomcat/cms/ControlPanel

cp -R cms/ControlPanel/* 	     	/tomcat/cms/ControlPanel/
cp -R cms/flash/*                   	/tomcat/cms/flash/
cp -R cms/ckeditor/*                    /tomcat/cms/ckeditor/
cp -R cms/images/*                      /tomcat/cms/images/
cp    cms/*                          	/tomcat/cms/


# -------------------
# Update Engine files
# -------------------

echo "Update Engine files"

cd ${BASE_DIR}/

cp -R engine/WEB-INF/classes/* 		/tomcat/engine/WEB-INF/classes/
cp -R engine/WEB-INF/email/*   		/tomcat/engine/WEB-INF/email/
cp -R engine/WEB-INF/lib/*     		/tomcat/engine/WEB-INF/lib/
cp -R engine/WEB-INF/dynamic-css/*  /tomcat/engine/WEB-INF/dynamic-css/
cp    engine/WEB-INF/*         		/tomcat/engine/WEB-INF/
cp    engine/*                 		/tomcat/engine/

# ---------------------
# Update Template files
# ---------------------

echo "Update Template files"

cd ${BASE_DIR}/

cp -R template/WEB-INF/classes/*  	/tomcat/template/WEB-INF/classes/
cp -R template/WEB-INF/lib/*      	/tomcat/template/WEB-INF/lib/
cp -R template/WEB-INF/template/* 	/tomcat/template/WEB-INF/template/
cp    template/WEB-INF/*          	/tomcat/template/WEB-INF/
cp    template/* 		 	/tomcat/template/

# ---------------------
# Update Admin files
# ---------------------

echo "Update Admin files"

cd ${BASE_DIR}/

cp -R admin/WEB-INF/classes/*  		/tomcat/admin/WEB-INF/classes/
cp -R admin/WEB-INF/lib/*      		/tomcat/admin/WEB-INF/lib/
cp    admin/WEB-INF/*          		/tomcat/admin/WEB-INF/
cp -R admin/AdminConsole/* 		/tomcat/admin/AdminConsole/
cp    admin/* 		 		/tomcat/admin/

# ---------------------
# Update API files
# ---------------------

echo "Update API files"

cd ${BASE_DIR}/

cp -R api/WEB-INF/classes/*  		/tomcat/api/WEB-INF/classes/
cp -R api/WEB-INF/lib/*      		/tomcat/api/WEB-INF/lib/
cp    api/WEB-INF/*          		/tomcat/api/WEB-INF/
cp    api/* 		 		/tomcat/api/

echo "Done"

# ---------------------
# Update File files
# ---------------------

echo "Update File files"

cd ${BASE_DIR}/

cp -R file/WEB-INF/classes/*  		/tomcat/file/WEB-INF/classes/
cp -R file/WEB-INF/lib/*      		/tomcat/file/WEB-INF/lib/
cp    file/WEB-INF/*          		/tomcat/file/WEB-INF/
cp    file/* 		 		/tomcat/file/

echo "Done"

# ---------------------
# Update GBase files
# ---------------------

echo "Update GBase files"

cd ${BASE_DIR}/

cp -R gbase/WEB-INF/classes/*  		/tomcat/gbase/WEB-INF/classes/
cp -R gbase/WEB-INF/lib/*      		/tomcat/gbase/WEB-INF/lib/
cp    gbase/WEB-INF/*          		/tomcat/gbase/WEB-INF/
cp    gbase/* 		 		/tomcat/gbase/

echo "Done"

# ---------------------
# Update REST API files
# ---------------------

echo "Update REST API files"

cd ${BASE_DIR}/

cp -R rest/WEB-INF/classes/*  		/tomcat/rest/WEB-INF/classes/
cp -R rest/WEB-INF/lib/*      		/tomcat/rest/WEB-INF/lib/
cp    rest/WEB-INF/*          		/tomcat/rest/WEB-INF/
cp    rest/* 		 		/tomcat/rest/

echo "Done"
# ---------------------------------------------
# Make sure all config files are in Unix format
# ---------------------------------------------

for app in admin api cms engine file gbase template
do
    cd "/tomcat/"$app"/WEB-INF/classes/"$app"-configuration"
    for dir in `ls`
    do 
    	if [ -d $dir ]; then
	     for file in `ls $dir`
	     do
	     	dos2unix $dir/$file
	     done    	     
    	else
    	     dos2unix $dir
    	fi
    done
done
