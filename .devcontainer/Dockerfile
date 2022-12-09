FROM rocker/rstudio:latest

RUN sudo apt -q update \
 && sudo apt install --assume-yes python3.10-venv \
 && sudo useradd paul \
 && sudo usermod -a -G sudo paul \
 && sudo echo "paul ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloudimg-ubuntu
