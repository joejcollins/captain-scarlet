# Consistent set of make tasks.
.DEFAULT_GOAL := report

clean:
	find . -name "*.pyc" -exec rm -f {} \;
	find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete

compile:
	. .venv/bin/activate
	python python -m pip install pip-tools
	python -m piptools compile -o requirements.txt setup.py && echo "-e ." >> requirements.txt

.PHONY:= docs  # because there is a directory called docs.
docs:
	. .venv/bin/activate
	python python -m mkdocs build --clean

format:
	. .venv/bin/activate
	python python -m black --config pyproject.toml .

mypy:
	. .venv/bin/activate
	python -m mypy ./src_python

report:
	. .venv/bin/activate
	python3 --version
	python3 -m pip list -v

requirements:
	python3 -m venv .venv
	. .venv/bin/activate
	python -m pip install --upgrade pip setuptools
	python -m pip install -r requirements.txt

test:
	. .venv/bin/activate
	python python -m pytest ./tests_unit
