.PHONY: fmt-tf
fmt-tf: ## Run terraform fmt.
	cd ./terraform && terraform fmt -recursive