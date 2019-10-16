.EXPORT_ALL_VARIABLES:

NAMESPACE 			:= pbrodner
VERSION				:= $(shell sed -n 's/^version: //p' Chart.yaml)
NAME				:= alfresco-identity-service
ROUTE53_HOSTNAME	:= pbrodner.ps.dev.alfresco.me
RANDOM 			 	:= $(shell openssl rand 200 | LC_CTYPE=C tr -dc "[:lower:]" | head -c 5)

build: clean
	helm repo add alfresco-incubator https://kubernetes-charts.alfresco.com/incubator
	helm repo add alfresco-stable https://kubernetes-charts.alfresco.com/stable
	rm -rf requirements.lock
	helm dependency build
	helm lint

deploy: 	
	helm upgrade --install --namespace $(NAMESPACE)  ${NAME} . 

secrets:
	@[ -f secrets.yaml ] && kubectl create -f secrets.yaml --namespace $(NAMESPACE)	

ingress:
	./custom-ingress.sh ingressvalues.yaml && \
	helm install stable/nginx-ingress --version=0.14.0 -f ingressvalues.yaml --namespace $(NAMESPACE)	

infrastructure:	
	helm install alfresco-stable/alfresco-infrastructure \
    --set alfresco-infrastructure.activemq.enabled=false \
    --set alfresco-infrastructure.alfresco-identity-service.enabled=false \
    --set alfresco-infrastructure.nginx-ingress.enabled=false \
    --namespace=$(NAMESPACE)

clean:
	rm -rf charts

delete:
	@helm delete --purge `helm ls --namespace $(NAMESPACE) -q`

# proxy a service
# kubectl get svc -n $(NAMESPACE)
#   NAME                                               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
#   alfresco-identity-se-headless                      ClusterIP   None             <none>        80/TCP     66s
#   alfresco-identity-se-http                          ClusterIP   10.100.223.126   <none>        80/TCP     66s

# kubectl port-forward svc/alfresco-identity-se-http 8080:80 -n $(NAMESPACE)

# https://github.com/Alfresco/alfresco-infrastructure-deployment#nginx-ingress-custom-configuration
# https://kubernetes.github.io/ingress-nginx/troubleshooting/