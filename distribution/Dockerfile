FROM quay.io/alfresco/alfresco-base-java:8
LABEL version="1.0"
LABEL maintainer="Platform Services Team"

ARG IDENTITY_VERSION=1.2
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin
ENV DB_VENDOR=H2
ENV LANG en_US.UTF-8

ENV IDENTITY_SERVICE_NAME alfresco-identity-service-$IDENTITY_VERSION.zip
ENV JBOSS_HOME /opt/alfresco-identity-service

USER root

COPY $IDENTITY_SERVICE_NAME .
RUN yum install -y unzip && yum clean all && \
    unzip -oq $IDENTITY_SERVICE_NAME && \
    mv alfresco-identity-service-$IDENTITY_VERSION $JBOSS_HOME && \
    rm -rf $IDENTITY_SERVICE_NAME

COPY ./docker/ $JBOSS_HOME/scripts/
RUN chmod +x $JBOSS_HOME/scripts/config-keycloak.sh && \
    $JBOSS_HOME/scripts/config-keycloak.sh

USER 1000

EXPOSE 8080

ENTRYPOINT [ "/opt/alfresco-identity-service/scripts/docker-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
