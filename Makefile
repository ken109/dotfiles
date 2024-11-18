DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(shell find .config -depth 1) $(wildcard .??*)
EXCLUSIONS := .config .DS_Store .git .gitignore .idea
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

.PHONY: list
list: ## Show dot files in this repo
	@$(foreach val,$(DOTFILES),/bin/ls -dF $(val);)

define link
	rm -rf $(HOME)/$(1);
	mkdir -p $(shell dirname $(HOME)/$(1));
	ln -s $(DOTPATH)/$(1) $(HOME)/$(1);
endef

.PHONY: deploy
deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@
	@$(foreach val,$(DOTFILES),$(call link,$(val)))

.PHONY: help
help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

