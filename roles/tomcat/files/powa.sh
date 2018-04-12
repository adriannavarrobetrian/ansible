#!/bin/bash

pushd /usr/local/tomcat/bin

DEBUG="-Xrunjdwp:transport=dt_socket,address=8085,server=y,suspend=n -Xdebug"
MONITOR="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8090 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

JETSTREAM="-Djetstream.build.ci.number=0 -Djetstream.build.revision=jrebel"

GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintTenuringDistribution -XX:-TraceClassUnloading -Xloggc:gc.log"

JVM_OPTS="-Xms1024m -Xmx4096m -XX:PermSize=64m -XX:MaxPermSize=512m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+ExplicitGCInvokesConcurrent -XX:+TieredCompilation -XX:+AlwaysPreTouch"
JVM_OPTS="$JVM_OPTS -XX:+DisableExplicitGC -XX:+UseCMSInitiatingOccupancyOnly -XX:NewSize=256M -XX:MaxNewSize=256M -XX:CMSInitiatingOccupancyFraction=60 -XX:SurvivorRatio=6 -XX:-OmitStackTraceInFastThrow"


POWA_PROJECT_PATH="/home/serban/dev/workspace/powa"
POWA_CONFIG="$POWA_PROJECT_PATH/configuration-dev-local"
POWA_CONFIG_OPTS="-Dpowa.config.dir=$POWA_CONFIG"
MODULE_ROOT="/out/production/"
CLASS_PATH=""

JREBEL="-javaagent:/opt/jrebel/jrebel.jar -Dpowa.project.path=$POWA_PROJECT_PATH -Dmodule.root=$MODULE_ROOT -Dclass.path=$CLASS_PATH"

# verbose can help with classpath conflicts and the like
#VERBOSE="-verbose"

export powa_crypt_password_file="$POWA_CONFIG/secret"

export JAVA_OPTS="$VERBOSE $JPROFILER $DEBUG $MONITOR $JREBEL $GC_OPTS $JVM_OPTS $JETSTREAM $POWA_CONFIG_OPTS"

mkdir /usr/local/tomcat/webapps/cms/upload

#Useful for debuging ssl problems -Djavax.net.debug=ssl"
env 'api.appender=console' 'admin.appender=console' 'cms.appender=console' 'engine.appender=console' 'gbase.appender=console' 'template.appender=console' 'file.appender=console' ./catalina.sh run

popd

