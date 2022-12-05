# Set the working directory
sudo bash -c "echo 'setwd(\"$CODESPACE_VSCODE_FOLDER\")' > /home/rstudio/.Rprofile"
sudo usermod -a -G sudo gitpod
# https://stackoverflow.com/questions/47541007/how-to-i-bypass-the-login-page-on-rstudio
sudo bash -c "echo 'server-user=gitpod' >> /etc/rstudio/rserver.conf"
sudo bash -c "echo 'auth-none=1' >> /etc/rstudio/rserver.conf"
# Start the rserver with sudo otherwise it won't run for the gitpod user
sudo rserver
