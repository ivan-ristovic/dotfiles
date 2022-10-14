FROM manjarolinux/base

RUN sudo pacman --noconfirm -Syu
RUN sudo pacman --noconfirm -S openssh stow

ARG PRIVATE_KEY
ARG PUBLIC_KEY

RUN useradd -ms /bin/bash user && \
        echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
        chmod 0440 /etc/sudoers.d/user

USER user:user

WORKDIR /home/user
RUN touch .bash_profile
RUN mkdir -p .ssh
RUN echo "$PRIVATE_KEY" > .ssh/id_rsa
RUN echo "$PUBLIC_KEY" > .ssh/id_rsa.pub
RUN chmod 600 .ssh/id_rsa
RUN chmod 600 .ssh/id_rsa.pub
RUN ssh-keyscan github.com >> .ssh/known_hosts

RUN mkdir -p dotfiles

CMD ["/bin/bash"]
