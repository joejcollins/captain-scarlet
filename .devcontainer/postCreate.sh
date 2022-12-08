# Set the working directory
sudo bash -c "echo R_LIBS_USER=$CODESPACE_VSCODE_FOLDER/../.R/library > /home/rstudio/.Renviron"
ln -s /workspace/captain-scarlet /home/rstudio/captain-scarlet
# # https://stackoverflow.com/questions/47541007/how-to-i-bypass-the-login-page-on-rstudio
# sudo usermod -a -G root rstudio
# sudo bash -c "echo 'server-user=rstudio' >> /etc/rstudio/rserver.conf"
# sudo bash -c "echo 'auth-none=1' >> /etc/rstudio/rserver.conf"
# # Restart the rserver with sudo otherwise it won't run for the local user (dunno why)
# sudo rserver
# sudo pkill rserver
# Setup the Python environment
python3 -m venv .venv
. .venv/bin/activate
pip install --upgrade pip setuptools
pip install -Ur requirements.txt
alias python='python3'
