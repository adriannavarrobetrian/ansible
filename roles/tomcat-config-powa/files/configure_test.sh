VERSION=$(date +"%Y%m%d01")
cd /root/backup/$VERSION/cfg

echo "--- ADMIN ---"
cp -v tomcat/admin/WEB-INF/classes/admin-run-profile.properties /tomcat/admin/WEB-INF/classes/admin-run-profile.properties
cp -v tomcat/admin/WEB-INF/classes/admin-configuration/app/admin.deploy.properties /tomcat/admin/WEB-INF/classes/admin-configuration/app/admin.deploy.properties
echo

echo "--- API ---"
cp -v tomcat/api/WEB-INF/classes/api-run-profile.properties /tomcat/api/WEB-INF/classes/api-run-profile.properties
cp -v tomcat/api/WEB-INF/classes/api-configuration/app/api.deploy.properties /tomcat/api/WEB-INF/classes/api-configuration/app/api.deploy.properties
echo

echo "--- CMS ---"
cp -v tomcat/cms/WEB-INF/classes/cms-run-profile.properties /tomcat/cms/WEB-INF/classes/cms-run-profile.properties
cp -v tomcat/cms/WEB-INF/classes/host.properties /tomcat/cms/WEB-INF/classes/host.properties
cp -v tomcat/cms/WEB-INF/classes/cms-configuration/app/cms.deploy.properties /tomcat/cms/WEB-INF/classes/cms-configuration/app/cms.deploy.properties

#cp -v tomcat/cms/WEB-INF/classes/cms-configuration/ebay/ebay.profile.sandbox.properties /tomcat/cms/WEB-INF/classes/cms-configuration/ebay/ebay.profile.sandbox.properties
cp -v tomcat/cms/WEB-INF/classes/cms-configuration/epdq/epdq.deploy.properties /tomcat/cms/WEB-INF/classes/cms-configuration/epdq/epdq.deploy.properties
cp -v tomcat/cms/WEB-INF/classes/cms-configuration/epdq/epdq.profile.sandbox.properties /tomcat/cms/WEB-INF/classes/cms-configuration/epdq/epdq.profile.sandbox.properties
cp -v tomcat/cms/WEB-INF/classes/cms-configuration/globalcollect/globalcollect.profile.production.properties /tomcat/cms/WEB-INF/classes/cms-configuration/globalcollect/globalcollect.profile.production.properties
cp -v tomcat/cms/WEB-INF/classes/cms-configuration/paypal/paypal.profile.sandbox.properties /tomcat/cms/WEB-INF/classes/cms-configuration/paypal/paypal.profile.sandbox.properties
cp -v tomcat/cms/WEB-INF/classes/cms-configuration/payon/payon.profile.sandbox.properties /tomcat/cms/WEB-INF/classes/cms-configuration/payon/payon.profile.sandbox.properties
echo

echo "--- ENGINE ---"
cp -v tomcat/engine/WEB-INF/classes/engine-run-profile.properties /tomcat/engine/WEB-INF/classes/engine-run-profile.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/app/engine.deploy.properties /tomcat/engine/WEB-INF/classes/engine-configuration/app/engine.deploy.properties

#cp -v tomcat/engine/WEB-INF/classes/engine-configuration/ebay/ebay.profile.sandbox.properties /tomcat/engine/WEB-INF/classes/engine-configuration/ebay/ebay.profile.sandbox.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/epdq/epdq.deploy.properties /tomcat/engine/WEB-INF/classes/engine-configuration/epdq/epdq.deploy.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/epdq/epdq.profile.sandbox.properties /tomcat/engine/WEB-INF/classes/engine-configuration/epdq/epdq.profile.sandbox.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/globalcollect/globalcollect.profile.production.properties /tomcat/engine/WEB-INF/classes/engine-configuration/globalcollect/globalcollect.profile.production.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/paypal/paypal.profile.sandbox.properties /tomcat/engine/WEB-INF/classes/engine-configuration/paypal/paypal.profile.sandbox.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/payon/payon.profile.sandbox.properties /tomcat/engine/WEB-INF/classes/engine-configuration/payon/payon.profile.sandbox.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/fetch/fetch.profile.sandbox.properties /tomcat/engine/WEB-INF/classes/engine-configuration/fetch/fetch.profile.sandbox.properties
cp -v tomcat/engine/WEB-INF/classes/engine-configuration/promotions/promotions.profile.sandbox.properties /tomcat/engine/WEB-INF/classes/engine-configuration/promotions/promotions.profile.sandbox.properties
echo

echo "--- FILE ---"
cp -v tomcat/file/WEB-INF/classes/file-run-profile.properties /tomcat/file/WEB-INF/classes/file-run-profile.properties
cp -v tomcat/file/WEB-INF/classes/file-configuration/app/file.deploy.properties /tomcat/file/WEB-INF/classes/file-configuration/app/file.deploy.properties
echo

echo "--- GBASE ---"
cp -v tomcat/gbase/WEB-INF/classes/gbase-run-profile.properties /tomcat/gbase/WEB-INF/classes/gbase-run-profile.properties
#cp -v tomcat/gbase/WEB-INF/classes/gbase-service-context.xml /tomcat/gbase/WEB-INF/classes/gbase-service-context.xml
cp -v tomcat/gbase/WEB-INF/classes/googleapi-configuration/configuration-env.xml /tomcat/gbase/WEB-INF/classes/googleapi-configuration/configuration-env.xml
cp -v tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/googleapi.run-profile.properties /tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/googleapi.run-profile.properties
cp -v tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/googleapi.common.properties /tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/googleapi.common.properties
cp -v tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/googleapi.deploy.properties /tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/googleapi.deploy.properties
cp -v tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/profile/googleapi.profile.properties /tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/profile/googleapi.profile.properties
cp -v tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/profile/googleapi.profile.pre-prod.properties /tomcat/gbase/WEB-INF/classes/googleapi-configuration/app/profile/googleapi.profile.pre-prod.properties
echo

echo "--- TEMPLATE ---"
cp -v tomcat/template/WEB-INF/classes/template-run-profile.properties /tomcat/template/WEB-INF/classes/template-run-profile.properties
cp -v tomcat/template/WEB-INF/classes/template-configuration/app/template.deploy.properties /tomcat/template/WEB-INF/classes/template-configuration/app/template.deploy.properties
echo

echo "--- REST ---"
cp -v tomcat/rest/WEB-INF/classes/rest-api-configuration/app/rest-api.settings.properties /tomcat/rest/WEB-INF/classes/rest-api-configuration/app/rest-api.settings.properties
cp -v tomcat/rest/WEB-INF/classes/rest-api-configuration/app/rest-api.deploy.properties /tomcat/rest/WEB-INF/classes/rest-api-configuration/app/rest-api.deploy.properties
echo
