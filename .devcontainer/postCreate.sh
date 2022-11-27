# Set the working directory
$CODESPACE_VSCODE_FOLDER
sudo bash -c "echo 'setwd(\"$CODESPACE_VSCODE_FOLDER\")' > /home/rstudio/.Rprofile"
sudo rstudio-server restart