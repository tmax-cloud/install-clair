NAMESPACE ?= registry-system
REGISTRY ?= arminc

resource:
	sed "s/__NAMESPACE__/${NAMESPACE}/g" kustomization.template > kustomization.yml
	sed -i "s/__REG__/${REGISTRY}/g" kustomization.yml
	-kubectl create ns ${NAMESPACE}
	kubectl kustomize . > resource.yml

deploy: resource
	kubectl apply -f resource.yml

clean:
	-kubectl delete -f resource.yml
	-rm -rf kustomization.yml resource.yml