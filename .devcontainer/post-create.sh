# Set the working directory
echo Renviron config
touch /home/rstudio/.Renviron
echo R_LIBS_USER=$CODESPACE_VSCODE_FOLDER/../.R/library > /home/rstudio/.Renviron
ln -s /workspaces/captain-scarlet /home/rstudio/captain-scarlet
# Restart the rserver with sudo otherwise it won't run for the local user (dunno why)
echo Rserver setup
sudo rserver
sudo pkill rserver
# Setup the Python environment
echo Python environment
python3 -m venv .venv
. .venv/bin/activate
pip install --upgrade pip setuptools
pip install -Ur requirements.txt
alias python='python3'
