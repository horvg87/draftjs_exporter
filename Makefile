.PHONY: clean-pyc init help
.DEFAULT_GOAL := help

help: ## See what commands are available.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36mmake %-15s\033[0m # %s\n", $$1, $$2}'

init: clean-pyc ## Install dependencies and initialise for development.
	pip install -e .[testing,docs]

lint: ## Lint the project.
	flake8 draftjs_exporter
	isort --check-only --diff --recursive draftjs_exporter
	flake8 tests
	isort --check-only --diff --recursive tests

test: ## Test the project.
	python -m unittest discover

# test-all: ## Use tox to run tests on all python versions.
# 	tox

test-watch: ## Restarts the tests whenever a file changes.
	nodemon -q -e py -w tests -w draftjs_exporter  -x "clear && make test -s || true"

test-ci: lint test ## Check for continuous integration.

dev: ## Restarts the example whenever a file changes.
	nodemon -q -e py -w tests -w draftjs_exporter  -x "clear && python example.py || true"

clean-pyc: ## Remove Python file artifacts.
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
