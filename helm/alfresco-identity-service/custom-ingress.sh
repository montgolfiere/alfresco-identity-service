#!/usr/bin/env bash
set -eu
cat <<EOF > $1
rbac:
  create: true
controller:
  config:
    ssl-redirect: "false"
  scope:
    enabled: true
    namespace: ${NAMESPACE}
  publishService:
    enabled: true
  service:
    targetPorts:
      http: http
      https: http
    annotations:
      external-dns.alpha.kubernetes.io/hostname: "*.${ROUTE53_HOSTNAME}"
      service.beta.kubernetes.io/aws-load-balancer-backend-protocol: "http"
      service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout: '3600'
      service.beta.kubernetes.io/aws-load-balancer-ssl-cert: ${ELB_CERTIFICATE_ARN}
      service.beta.kubernetes.io/aws-load-balancer-ssl-ports: https
EOF
