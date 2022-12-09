# Set the working directory
echo Renviron config
touch /home/paul/.Renviron
echo R_LIBS_USER=$CODESPACE_VSCODE_FOLDER/../.R/library > /home/paul/.Renviron
ln -s /workspace/captain-scarlet /home/paul/captain-scarlet
# https://stackoverflow.com/questions/47541007/how-to-i-bypass-the-login-page-on-rstudio
echo Rstudio login
sudo bash -c "echo 'server-user=paul' >> /etc/rstudio/rserver.conf"
sudo bash -c "echo 'auth-none=1' >> /etc/rstudio/rserver.conf"
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
