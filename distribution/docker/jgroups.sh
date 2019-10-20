#!/bin/bash

JGROUPS_DISCOVERY_PROTOCOL=$1
# This parameter must be in the following format: PROP1=FOO,PROP2=BAR
JGROUPS_DISCOVERY_PROPERTIES=$2

if [ -n "$JGROUPS_DISCOVERY_PROTOCOL" ]; then
    JGROUPS_DISCOVERY_PROPERTIES_PARSED=`echo $JGROUPS_DISCOVERY_PROPERTIES | sed "s/=/=>/g"`
    JGROUPS_DISCOVERY_PROPERTIES_PARSED="{$JGROUPS_DISCOVERY_PROPERTIES_PARSED}"
    echo "Setting JGroups discovery to $JGROUPS_DISCOVERY_PROTOCOL with properties $JGROUPS_DISCOVERY_PROPERTIES_PARSED"
    echo "set keycloak_jgroups_discovery_protocol=${JGROUPS_DISCOVERY_PROTOCOL}" >> "$AIMS_HOME/bin/.jbossclirc"
    echo "set keycloak_jgroups_discovery_protocol_properties=${JGROUPS_DISCOVERY_PROPERTIES_PARSED}" >> "$AIMS_HOME/bin/.jbossclirc"
    # If there's a specific CLI file for given protocol - execute it. If not, we should be good with the default one.
    if [ -f "$ALFRESCO_HOME/scripts/cli/jgroups/discovery/$JGROUPS_DISCOVERY_PROTOCOL.cli" ]; then
       $AIMS_HOME/bin/jboss-cli.sh --file="$ALFRESCO_HOME/scripts/cli/jgroups/discovery/$JGROUPS_DISCOVERY_PROTOCOL.cli" >& /dev/null
    else
       $AIMS_HOME/bin/jboss-cli.sh --file="$ALFRESCO_HOME/scripts/cli/jgroups/discovery/default.cli" >& /dev/null
    fi
fi