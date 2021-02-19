FROM gitpod/workspace-full

# Install LaTeX
RUN sudo apt-get update \
 && sudo apt-get install -yq texlive \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo apt-get install -y r-base gdebi-core \
 && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1103-amd64.deb \
 && sudo gdebi -n rstudio-server-1.4.1103-amd64.deb \
 && sudo groupadd rstudio-users \
 && sudo usermod -a -G rstudio-users gitpod \
 && sudo touch /etc/rstudio/rserver.conf \
 && sudo bash -c "echo auth-required-user-group=rstudio-users > /etc/rstudio/rserver.conf" \
 && sudo touch /home/gitpod/.Rprofile \
 && sudo bash -c "echo 'setwd(\"/workspace/captain-scarlet\")' >> /home/gitpod/.Rprofile"
