SHELL := /bin/bash
MAKEFILE_RULES := $(shell cat Makefile | grep "^[A-Za-z]" | awk '{print $$1}' | sed "s/://g" | sort -u)

.SILENT: help
.PHONY: $(MAKEFILE_RULES)

default: help

foodcritic: ## Run Foodcritic against site-cookbooks
	@echo "http://www.foodcritic.io/"
	foodcritic --epic-fail any ./

rubocop: ## Run rubocop linter against site-cookbooks/ , spec/ and serverspec/ directories
	@echo https://github.com/bbatsov/rubocop
	rubocop --format simple ./

test:  ## Run ChefSpec and all linters (Runs on Jenkins)
test: foodcritic rubocop

help:  ## This help dialog.
	echo "     ___ _           __                _         __ _ _        "
	echo "    / __\ |__   ___ / _|   /\/\   __ _| | _____ / _(_) | ___   "
	echo "   / /  | '_ \ / _ \ |_   /    \ / _' | |/ / _ \ |_| | |/ _ \  "
	echo "  / /___| | | |  __/  _| / /\/\ \ (_| |   <  __/  _| | |  __/  "
	echo "  \____/|_| |_|\___|_|   \/    \/\__,_|_|\_\___|_| |_|_|\___|  "
	echo "    You can run the following commands from this$(MAKEFILE_LIST):\n"
	IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sort`) ; \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done
