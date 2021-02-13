FROM gitpod/workspace-full

RUN sudo apt-get update \
    && sudo apt-get install -y r-base gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1103-amd64.deb \
    && sudo gdebi -n rstudio-server-1.4.1103-amd64.deb
    && rm rstudio-server-1.4.1103-amd64.deb
    && sudo rstudio-server stop
