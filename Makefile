MISSING_ENV := "\n❌ Missing .env file, please use .env.example to create your own.\n"
MISSING_KEYS := "\n❌ You need to set your own secret key credentials, please edit your .env file and replace CHANGEME with the correct value.\n"
ALL_GOOD := "\n✅ All good!🎉🎉\n"

.DEFAULT_GOAL := help

.PHONY: help
help:  ## Shows this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target> <arg=value>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m  %s\033[0m\n\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ 🚀 Getting started
.PHONY: check
check: ## Verify if you have all configured
ifeq (,$(wildcard ./.env))
	@echo $(MISSING_ENV)
	exit 1
endif

ifneq (,$(findstring CHANGEME, $(shell cat .env)))
	@echo $(MISSING_KEYS) 
	exit 1
else 
	@docker-compose config 
	@echo $(ALL_GOOD)
endif


.PHONY: build
build: ## Build docker image including base dependencies
	@docker-compose build

.PHONY: up
up: ## Boot up quickstart app
	@docker-compose up

.PHONY: run
run: check build up ## Check, build and start containers

