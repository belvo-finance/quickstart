MISSING_KEYS := "You need to set your own secret key credentials, please edit your .env file and replace CHANGEME with the correct value."

.DEFAULT_GOAL := help

.PHONY: help
help:  ## Shows this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target> <arg=value>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m  %s\033[0m\n\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ 🚀 Getting started
.PHONY: check
check: ## Verify if you have all configured
ifeq (,$(wildcard ./.env))
	@echo "Missing .env file, please use .env.example to create your own."
	exit 1;
endif
	if grep -q CHANGEME .env; then echo $(MISSING_KEYS); exit 1; else docker-compose config; echo "\nAll good!🎉🎉"; fi


.PHONY: build
build: ## Build docker image including base dependencies
	@docker-compose build

.PHONY: up
up: ## Boot up quickstart app
	@docker-compose up

.PHONY: run
run: check build up ## Check, build and start containers
