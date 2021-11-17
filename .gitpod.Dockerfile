FROM gitpod/workspace-full:latest

# Redis, Python 3.6.10 and Starship
RUN sudo apt-get update \
 && sudo apt-get install -y redis-server \
 && sudo rm -rf /var/lib/apt/lists/* \
 && pyenv install 3.6.10 \
 && curl -fsSL https://starship.rs/install.sh | bash -s -- --yes
