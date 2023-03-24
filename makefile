# Consistent set of make tasks.
.DEFAULT_GOAL:= help  # because it's is a safe task.

clean:  # Remove all build, test, coverage and Python artifacts.
	find . -name "*.pyc" -exec rm -f {} \;
	find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete

compile:  # Compile the requirements files using pip-tools.
	. .venv/bin/activate; python -m pip install pip-tools
	. .venv/bin/activate; python -m piptools compile --extra=test --extra=dev -o requirements.txt pyproject.toml && echo "-e ." >> requirements.txt

.PHONY: docs  # because there is a directory called docs.
docs:
	. .venv/bin/activate; python -m mkdocs build --clean

format:  # Format the code with black..
	. .venv/bin/activate; python -m black --config pyproject.toml ./src_python

.PHONY: help
help: # Show help for each of the makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

lint:  # Lint the code with ruff.
	. .venv/bin/activate; python -m ruff .

mypy:  # Type check the code with mypy.
	. .venv/bin/activate; python -m mypy ./src_python

report:  # Report the python version and pip list.
	. .venv/bin/activate; python3 --version
	. .venv/bin/activate; python3 -m pip list -v

requirements:  # Install the requirements for Python.
	python3 -m venv .venv
	. .venv/bin/activate; python -m pip install --upgrade pip setuptools
	. .venv/bin/activate; python -m pip install -r requirements.txt

test:  # Run the tests.
	. .venv/bin/activate; python -m pytest ./src_python/pytest_unit
