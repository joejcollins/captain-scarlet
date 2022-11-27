# Set the working directory
sudo rstudio-server stop
sudo bash -c "echo 'setwd(\"$CODESPACE_VSCODE_FOLDER\")' > /home/rstudio/.Rprofile"
sudo rstudio-server start