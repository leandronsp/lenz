SHELL = /bin/bash
.ONESHELL:
.DEFAULT_GOAL: help

help: ## Prints available commands
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[.a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

bundle.install: ## Installs the Ruby gems
	@docker-compose run --rm ruby bundle install

bash: ## Creates a container Bash
	@docker-compose run --rm ruby bash

rubocop: ## Runs code linter with auto-correction
	@docker-compose run --rm ruby rubocop -A

ci: ## Runs code linter and unit tests in CI
	bundle lock --add-platform x86_64-linux
	bundle install
	rubocop

app.server: ## Runs a specific app server
	@docker-compose run \
		--rm \
		-p ${port}:${port} \
		ruby \
		bash -c "apps/${app}/bin/server"

run.tests: ## Runs the unit tests for a specific app
	@docker-compose run \
		--rm \
		ruby ruby -Itest apps/${app}/test/all.rb

docker.network: ## Creates the "lenz" Docker network
	@docker network create lenz

postgres: ## Runs a Postgres container
	@bash -c "bin/postgres"

app.seed: ## Seed a specific app
	@docker-compose run \
		--rm \
		ruby \
		ruby apps/${app}/lib/seeds.rb
