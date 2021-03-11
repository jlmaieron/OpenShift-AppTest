# dockerfile to build new image from eap73-openjdk11-openshift-rhel8

FROM registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8:latest

USER jboss

ENV JBOSS_HOME /opt/eap
ENV INSTANCE ${JBOSS_HOME}/standalone
ENV DEPLOYMENT_DIR ${INSTANCE}/deployments

# JBoss ports
EXPOSE 8080 9990 9999

# create JBoss console user
RUN $JBOSS_HOME/bin/add-user.sh admin Admin1234! --silent

# deploy app
#ADD target/testrest.war "$DEPLOYMENT_DIR/"

#RUN mv $INSTANCE/configuration/standalone.xml $INSTANCE/configuration/standalone.xml.ori
#RUN mv $INSTANCE $INSTANCE-ORI

COPY target/testrest.war ${DEPLOYMENT_DIR}/
COPY eap/standalone/deployments/testrest.war.dodeploy ${DEPLOYMENT_DIR}/


#COPY eap/standalone/jbstart.sh ${INSTANCE}
#RUN chmod -R 777 $INSTANCE/

# ------------------------------------------------------------------------------------------------
#USER jboss

# Set the default command to run on boot
# This will boot JBoss in the standalone mode and bind to all interface
#CMD ["/opt/eap/bin/standalone.sh", "-b", "0.0.0.0"]

#CMD $INSTANCE/jbstart.sh
CMD $JBOSS_HOME/bin/openshift-launch.sh
