.PHONY: install-tools create-cluster deploy-staging deploy-prod

install-tools:
	./scripts/install-tools.sh

create-cluster:
	./scripts/create-cluster.sh

deploy-staging:
	helm upgrade --install website-staging ./helm/website-chart \
		-f ./helm/website-chart/values-staging.yaml \
		--namespace staging \
		--create-namespace

deploy-prod:
	helm upgrade --install website-prod ./helm/website-chart \
		-f ./helm/website-chart/values-prod.yaml \
		--namespace production \
		--create-namespace
