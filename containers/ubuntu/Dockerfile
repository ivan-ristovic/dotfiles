FROM ubuntu:latest

RUN apt-get update && apt-get install -y sudo git ssh bc

RUN useradd -ms /bin/bash user && \
        mkdir -p /etc/sudoers.d && \
        echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
        chmod 0440 /etc/sudoers.d/user

USER user:user

WORKDIR /home/user
RUN touch .bash_profile

RUN mkdir -p dotfiles

CMD ["/bin/bash"]
