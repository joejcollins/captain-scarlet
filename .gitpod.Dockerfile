FROM gitpod/workspace-full

RUN sudo add-apt-repository ppa:x4121/ripgrep -y \
    && sudo apt-get update \
    && sudo apt install ripgrep