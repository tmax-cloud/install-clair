REGISTRY ?= arminc

resource:
	sed "s/__REG__/${REGISTRY}/g" kustomization.template > kustomization.yml
	kubectl kustomize . > resource.yml

deploy: resource
	kubectl apply -f resource.yml

clean:
	-kubectl delete -f resource.yml
	-rm -rf kustomization.yaml resource.yml
