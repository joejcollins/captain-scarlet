FROM mcr.microsoft.com/devcontainers/base:jammy

# Install Rstudio Server
RUN sudo apt -q update \
 && sudo apt install --assume-yes --no-install-recommends software-properties-common dirmngr \
 && wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
 && sudo add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
 && sudo apt install --assume-yes r-base gdebi-core \
 && wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.2-576-amd64.deb \
 && sudo gdebi -n rstudio-server-2022.07.2-576-amd64.deb \
 && sudo rm rstudio-server-2022.07.2-576-amd64.deb

# Allow the vscode user to run Rstudio Server
RUN sudo usermod -a -G root vscode \
 && sudo touch /etc/rstudio/rserver.conf \
 && sudo bash -c "echo 'server-user=vscode' >> /etc/rstudio/rserver.conf" \
 && sudo bash -c "echo 'auth-none=1' >> /etc/rstudio/rserver.conf"
