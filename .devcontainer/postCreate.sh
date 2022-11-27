# Set the working directory
sudo rstudio-server restart
sudo bash -c "echo 'setwd(\"$CODESPACE_VSCODE_FOLDER\")' > /home/rstudio/.Rprofile"
sudo rstudio-server restart