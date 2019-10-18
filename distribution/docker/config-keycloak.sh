#!/bin/bash -e

######################
# Configure Keycloak #
######################

cd $JBOSS_HOME
echo "---------------------------- $JBOSS_HOME"
echo "$(pwd)"
echo "$(ls)"
bin/jboss-cli.sh --file=$JBOSS_HOME/scripts/cli/standalone-configuration.cli
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history

bin/jboss-cli.sh --file=$JBOSS_HOME/scripts/cli/standalone-ha-configuration.cli
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history

###################
# Set permissions #
###################

echo "jboss:x:1000:1000:JBoss user:$JBOSS_HOME:/sbin/nologin" >> /etc/passwd
chown -R jboss:0 $JBOSS_HOME
chmod -R g+rw $JBOSS_HOME