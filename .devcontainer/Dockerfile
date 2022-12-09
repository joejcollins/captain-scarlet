FROM rocker/rstudio:latest

RUN sudo apt -q update \
 && sudo apt install --assume-yes python3.10-venv
 && sudo usermod -a -G sudo rstudio
