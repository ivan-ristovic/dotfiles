FROM archlinux:base

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S openssh git stow sudo vim

ARG PRIVATE_KEY
ARG PUBLIC_KEY

RUN useradd -ms /bin/bash user && \
        echo "root ALL=(ALL) NOPASSWD:ALL" >  /etc/sudoers && \
        echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
        chmod 0440 /etc/sudoers

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
