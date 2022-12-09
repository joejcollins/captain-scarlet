# Setup the Python environment
echo Python environment
python3 -m venv .venv
. .venv/bin/activate
pip install --upgrade pip setuptools
pip install -Ur requirements.txt
alias python='python3'
