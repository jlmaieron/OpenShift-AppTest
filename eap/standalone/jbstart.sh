
JBOSS_SERVER_INSTANCE=standalone
JBOSS_SERVER_VERSION=eap-7.3

echo JBoss $JBOSS_SERVER_VERSION - Instance $JBOSS_SERVER_INSTANCE running

echo Building server...
echo 
export JBOSS_HOME=/opt/eap
export JBOSS_SERVER_BASE="$JBOSS_HOME/$JBOSS_SERVER_INSTANCE"

#export JAVA_HOME=/opt/java/jdk1.8.0_281

# JBOSS_JMS_RESOURCE_ADAPTER_NAME=

APP_JAR=
APP_CONF=
#export APP_JARS=$CONF_ROOT/app-modules
#export APP_CONF=%CONF_ROOT%/app-conf
#export DB_CONF=-P %APP_CONF%\N-1.properties
DB_CONF=

STANDALONE_FILE=--server-config=standalone.xml
# export STANDALONE_FILE=--server-config=standalone-$JBOSS_SERVER_INSTANCE.xml

#lo reemplazamos colocando en el persistence.xml <validation-mode>NONE</validation-mode>
# JAVA_OPTS=%JAVA_OPTS% -Dspring.config.location=file:///%JBOSS_SERVER_BASE%\spring-jpa.properties
# JAVA_OPTS=%JAVA_OPTS% -Dorg.apache.spring.validation.mode=VALIDATION_NONE

#JAVA_OPTS=%JAVA_OPTS% -Dejb.resource-adapter-name=%JBOSS_JMS_RESOURCE_ADAPTER_NAME%
JAVA_OPTS="$JAVA_OPTS -Djboss.node.name=$JBOSS_SERVER_VERSION-$JBOSS_SERVER_INSTANCE"
JAVA_OPTS="$JAVA_OPTS -Djboss.tx.node.id=1234"

# JAVA_OPTS=%JAVA_OPTS% -Duser.language=en -Duser.country=US 
# JAVA_OPTS=%JAVA_OPTS% -Dsun.jnu.encoding=ISO-8859-15
# JAVA_OPTS=%JAVA_OPTS% -Dfile.encoding=ISO-8859-15

# -------------------------------------------------------------------------
# Security policies
# JAVA_OPTS=%JAVA_OPTS% -Djava.security.manager -Djava.security.policy=file:///%JBOSS_SERVER_BASE%/configuration/coco-security.policy
# JAVA_OPTS=%JAVA_OPTS% -Djava.security.debug


# -------------------------------------------------------------------------
# JVM memory allocation pool parameters. Modify as appropriate.
# JAVA_OPTS=%JAVA_OPTS% -server -Xms1024m -Xmx1024m
JAVA_OPTS="$JAVA_OPTS -server -Xms524m -Xmx524m"
# -------------------------------------------------------------------------
# Garbage collector tunning
# JAVA_OPTS=%JAVA_OPTS% -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 
# JAVA_OPTS="$JAVA_OPTS -XX:+UseG1GC -XX:MaxGCPauseMillis=500"
# JAVA_OPTS="$JAVA_OPTS -verbose:gc -Xloggc:gc_node1.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCApplicationStoppedTime"

# -------------------------------------------------------------------------
#  JAVA_OPTS=%JAVA_OPTS% -Dhttp.proxyHost=localhost -Dhttp.proxyPort=3128
JAVA_OPTS="$JAVA_OPTS -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true" 

#  JAVA_OPTS=%JAVA_OPTS% -Dorg.jboss.logmanager.nocolor=true
JAVA_OPTS="$JAVA_OPTS -Djboss.bind.address.management=localhost"
JAVA_OPTS="$JAVA_OPTS -Djboss.home.dir=$JBOSS_HOME -Djboss.server.base.dir=$JBOSS_SERVER_BASE"

#export JBOSS_MODULEPATH="$JBOSS_HOME/modules;$APP_CONF;$APP_JARS"
export JBOSS_MODULEPATH="$JBOSS_HOME/modules"
SERVER_OPTS=" -b 0.0.0.0 $STANDALONE_FILE"

# BYTEMAN_HOME=%_JBOSS_HOME%/byteman
# JAVA_OPTS=%JAVA_OPTS% -javaagent:%BYTEMAN_HOME%/lib/byteman.jar=script:%BYTEMAN_HOME%/scripts/NoClassDefFoundError.btm,boot:%BYTEMAN_HOME%/lib/byteman.jar,boot:%BYTEMAN_HOME%/lib/byteman-helpers.jar,listener:true,port:9091 -Dorg.jboss.byteman.transform.all=true -Dorg.jboss.byteman.compileToBytecode=true -DNoClassDefFoundErrorClass=javax.resource.ResourceException

# -------------------------------------------------------------------------
# JBoss PORT Configuration
# -------------------------------------------------------------------------
DEBUG_PORT="--debug 8787"
PORTSET=1

JAVA_OPTS="$JAVA_OPTS -Djboss.ejb.listener.port=4447"
JAVA_OPTS="$JAVA_OPTS -Djboss.ejb.remoting.port=4447"

# set /a HTTP_PORT=8000 + (PORTSET * 10)
# set /a CONNECTOR_REMOTING=HTTP_PORT + 1
# set /a MANAGEMENT_NATIVE=HTTP_PORT + 2
# set /a MANAGEMENT_HTTP=HTTP_PORT + 3
# set /a CONNECTOR_RECOVERY=HTTP_PORT + 4
# set /a CONNECTOR_STATUS=HTTP_PORT + 5

# set JAVA_OPTS=%JAVA_OPTS% -Djboss.http.port=%HTTP_PORT%
# set JAVA_OPTS=%JAVA_OPTS% -Djboss.connector.remoting=%CONNECTOR_REMOTING%
# set JAVA_OPTS=%JAVA_OPTS% -Djboss.management.native.port=%MANAGEMENT_NATIVE%
# set JAVA_OPTS=%JAVA_OPTS% -Djboss.management.http.port=%MANAGEMENT_HTTP%
# set JAVA_OPTS=%JAVA_OPTS% -Djboss.connector.txnrecovery=%CONNECTOR_RECOVERY%
# set JAVA_OPTS=%JAVA_OPTS% -Djboss.connector.txnstatus=%CONNECTOR_STATUS%
# set JAVA_OPTS=%JAVA_OPTS% -Djboss.jgroups.tcp.port=%((8006 + (%PORTSET% * 10)))%
# set JAVA_OPTS=%JAVA_OPTS% -Djboss.jgroups.tcpfd.port=%((8007 + (%PORTSET% * 10)))%


export JAVA_OPTS
 
# -------------------------------------------------------------------------
# JBoss Startup Server
# -------------------------------------------------------------------------
#echo $JAVA_OPTS
$JBOSS_HOME/bin/standalone.sh $DB_CONF $DEBUG_PORT $SERVER_OPTS



