# Set the working directory and restart
sudo bash -c "echo 'setwd(\"$CODESPACE_VSCODE_FOLDER\")' > /home/rstudio/.Rprofile"
sudo rstudio-server restart