kustomize.yml:
	kubectl kustomize . > kustomize.yml

deploy: kustomize.yml
	kubectl apply -f kustomize.yml

clean:
	kubectl delete -f kustomize.yml
	rm -rf kustomize.yml