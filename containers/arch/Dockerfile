FROM archlinux:multilib-devel

RUN pacman --noconfirm -Syu openssh git stow sudo vim bc

RUN useradd -ms /bin/bash user && \
        echo "root ALL=(ALL) NOPASSWD:ALL" >  /etc/sudoers && \
        echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
        chmod 0440 /etc/sudoers

USER user:user

WORKDIR /home/user
RUN touch .bash_profile

RUN mkdir -p dotfiles

CMD ["/bin/bash"]
