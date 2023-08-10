DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(shell find .config -type f) $(wildcard .??*)
EXCLUSIONS := .config .DS_Store .git .gitignore .idea
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

list: ## Show dot files in this repo
	@$(foreach val,$(DOTFILES),/bin/ls -dF $(val);)

define copy
	mkdir -p $(shell dirname $(HOME)/$(1));
	cp $(1) $(HOME)/$(1);
endef

deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@
	@$(foreach val,$(DOTFILES),$(call copy,$(val)))

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
