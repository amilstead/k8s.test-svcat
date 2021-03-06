# setup

Make sure kubernetes & kubectl are installed.

Run `make setup`

Run `make bootstrap-db`

Then `skaffold dev` as often as you like.

You may need to wait a while in between setup steps, as the things that happen in k8s after running them may take some time.

# Make usage

Usage:

```
-------------------------------- Setup Targets: --------------------------------
make setup:
	 Bootstrap a local service platform.

make setup-helm:
	 Setup and install Helm from https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

make setup-svcat:
	 Setup and install Service Catalog CRDs.

make setup-minibroker:
	 Setup and install Minibroker.

----------------------------- Provisioner Targets: -----------------------------
make provision-database:
	 Provision a database using service brokers.

------------------------------ Bootstrap Targets: ------------------------------
make bootstrap-db:
	 Provision and bootstrap a database for simple-service in ./app.
```
