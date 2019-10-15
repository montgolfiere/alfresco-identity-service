NAMESPACE 	:= pbrodner
VERSION		:= $(shell sed -n 's/^version: //p' Chart.yaml)
NAME		:= alfresco-identity-service

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