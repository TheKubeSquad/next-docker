TAG ?= latest

build:
	docker build . -t next-docker:$(TAG)

deploy: 
	-kubectl create namespace next-docker
	-kubectl apply -f ./k8s-manifest.yaml
	kubectl wait --for=condition=ready pod -l app=next-docker -n next-docker --timeout=120s
	kubectl port-forward next-docker -n next-docker 3000:3000

cleanup:
	-kubectl delete -f ./k8s-manifest.yaml
	-kubectl delete namespace next-docker