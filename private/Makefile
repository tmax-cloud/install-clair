deployment.yml:
	kubectl kustomize . > deployment.yml


deploy: deployment.yml
	kubectl apply -f deployment.yml

clean:
	kubectl delete -f deployment.yml
	rm -rf deployment.yml