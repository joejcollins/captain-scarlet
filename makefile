venv: .venv/touchfile

.venv/touchfile: requirements.txt
	test -d .venv || virtualenv .venv
	export PIP_USER=no
	. .venv/bin/activate; pip install --upgrade pip setuptools
	. .venv/bin/activate; pip install -Ur requirements.txt
	# Script to start flask
	@echo "#\!/bin/bash" > .venv/flask.sh
	@echo ". .venv/bin/activate" >> .venv/flask.sh
	@echo "export FLASK_APP=flask_app" >> .venv/flask.sh
	@echo "export FLASK_ENV=development"  >> .venv/flask.sh
	@echo "flask run"  >> .venv/flask.sh
	chmod u+x .venv/flask.sh
	# Done now
	touch .venv/touchfile

test: venv
	. .venv/bin/activate; pytest

clean:
	rm -rf .venv
	find . -name "*.pyc" -exec rm -f {} \;
	find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete