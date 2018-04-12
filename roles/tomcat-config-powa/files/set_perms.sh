#!/bin/sh

echo -n "Processing CMS... "
chown -R tomcat:tomcat /tomcat/cms/WEB-INF/classes/
chown -R tomcat:tomcat /tomcat/cms/WEB-INF/deploy/
chown -R tomcat:tomcat /tomcat/cms/WEB-INF/email/
chown -R tomcat:tomcat /tomcat/cms/WEB-INF/lib/
chown -R tomcat:tomcat /tomcat/cms/WEB-INF/freemarker/
chown tomcat:tomcat /tomcat/cms/WEB-INF/*
chown -R tomcat:tomcat /tomcat/cms/ControlPanel/
chown -R tomcat:tomcat /tomcat/cms/flash/
chown -R tomcat:tomcat /tomcat/cms/ckeditor/
#chown -R tomcat:tomcat /tomcat/cms/secure/
chown -R tomcat:tomcat /tomcat/cms/images/
chown tomcat:tomcat /tomcat/cms/*
echo "done."

echo -n "Processing Engine... "
chown -R tomcat:tomcat /tomcat/engine/WEB-INF/classes/
chown -R tomcat:tomcat /tomcat/engine/WEB-INF/email/
chown -R tomcat:tomcat /tomcat/engine/WEB-INF/lib/
chown -R tomcat:tomcat /tomcat/engine/WEB-INF/dynamic-css/
chown tomcat:tomcat /tomcat/engine/WEB-INF/*
chown tomcat:tomcat /tomcat/engine/*
echo "done."

echo -n "Processing Template... "

chown -R tomcat:tomcat /tomcat/template/WEB-INF/classes/
chown -R tomcat:tomcat /tomcat/template/WEB-INF/lib/
# Set permissions for all templates except "runtime" and "vendors"
for i in `ls /tomcat/template/WEB-INF/template/ | egrep -v "runtime|vendors"`
do
    chown -R tomcat:tomcat '/tomcat/template/WEB-INF/template/'$i
done
chown tomcat:tomcat /tomcat/template/WEB-INF/*
chown -R tomcat:tomcat /tomcat/template/upload/
chown tomcat:tomcat /tomcat/template/*
echo "done."

echo -n "Processing other modules... "
chown -R tomcat:tomcat /tomcat/admin
chown -R tomcat:tomcat /tomcat/api
chown -R tomcat:tomcat /tomcat/file
chown -R tomcat:tomcat /tomcat/gbase
echo "done."
