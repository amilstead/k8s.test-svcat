HELM_INSTALL_URL := https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

setup-helm:
	@curl $(HELM_INSTALL_URL) | bash

setup-svcat:
	@helm repo add svc-cat https://svc-catalog-charts.storage.googleapis.com
	@helm repo update
	@-kubectl create ns catalog
	@-helm --namespace catalog install catalog svc-cat/catalog

setup-minibroker:
	@helm repo add minibroker https://minibroker.blob.core.windows.net/charts
	@helm repo update
	@-kubectl create ns minibroker
	@-helm --namespace minibroker install minibroker minibroker/minibroker

provision-database:
	@kubectl apply -f ./infra/platform/database.yaml
	@sleep 2

bootstrap-db: provision-database
	@-kubectl delete job.batch/simple-service-db-bootstrapper
	@BOOTSTRAP_DB=true skaffold run
	@-sleep 2
	@-kubectl logs -f job.batch/simple-service-db-bootstrapper
	@-kubectl delete job.batch/simple-service-db-bootstrapper

setup: setup-svcat setup-minibroker bootstrap-db

usage:
	@echo -------------------------------- Setup Targets: --------------------------------
	@echo make setup:
	@echo -e \\t Bootstrap a local service platform.
	@echo
	@echo make setup-helm:
	@echo -e \\t Setup and install Helm from $(HELM_INSTALL_URL)
	@echo
	@echo make setup-svcat:
	@echo -e \\t Setup and install Service Catalog CRDs.
	@echo
	@echo make setup-minibroker:
	@echo -e \\t Setup and install Minibroker.
	@echo

	@echo ----------------------------- Provisioner Targets: -----------------------------
	@echo make provision-database:
	@echo -e \\t Provision a database using service brokers.
	@echo

	@echo ------------------------------ Bootstrap Targets: ------------------------------
	@echo make bootstrap-db:
	@echo -e \\t Provision and bootstrap a database for simple-service in ./app.


.DEFAULT_GOAL := usage
.PHONY: usage setup bootstrap-db provision-datbase setup setup-helm setup-svcat setup-minibroker
