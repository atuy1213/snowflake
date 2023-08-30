.PHONY: fmt-tf
fmt-tf: ## Run terraform fmt.
	cd ./terraform && terraform fmt -recursive

.PHONEY: dbt-debug
dbt-debug: ## Run dbt debug
	cd ./dbt && \
	docker image build -t merlot/dbt:latest . && \
	docker run -it --env-file .env merlot/dbt:latest dbt debug

.PHONEY: dbt-run
dbt-run: ## Run dbt run. (e.g. make dbt-run TAG=report)
	cd ./dbt && \
	docker image build -t merlot/dbt:latest . && \
	docker run -it --env-file .env merlot/dbt:latest dbt run --select tag:$(TAG)

.PHONEY: dbt-test
dbt-test: ## Run dbt test. (e.g. make dbt-test)
	cd ./dbt && \
	docker image build -t merlot/dbt:latest . && \
	docker run -it --env-file .env merlot/dbt:latest dbt test
