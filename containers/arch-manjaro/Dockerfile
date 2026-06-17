FROM manjarolinux/base

RUN sudo pacman --noconfirm -Syu
RUN sudo pacman --noconfirm -S openssh yay binutils git stow

RUN useradd -ms /bin/bash user && \
        echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
        chmod 0440 /etc/sudoers.d/user

USER user:user

WORKDIR /home/user
RUN touch .bash_profile

RUN mkdir -p dotfiles

CMD ["/bin/bash"]
