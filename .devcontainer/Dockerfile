FROM rocker/rstudio:latest

RUN sudo apt -q update \
 && sudo apt install --assume-yes python3.10-venv \
 && sudo usermod -aG sudo rstudio \
 && sudo echo "rstudio ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloudimg-ubuntu
