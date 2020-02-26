FROM kalilinux/kali-rolling 

RUN apt-get update && apt-get dist-upgrade -y

RUN apt-get install -y zsh \
      tmux \
      neovim \
      python3 \
      python3-virtualenv \
      python3-pip \
      python3-jedi \
      python3-pylint-common \
      virtualenvwrapper \
      automake \
      curl \
      autoconf \
      sudo \
      unzip \
      build-essential \
      libtool \
      gdb-multiarch \
      gcc-multilib \
      git \
      wget \
      netcat \
      ripgrep \
      fd-find \
      ssh \
      fzf \
      nmap \
      make \
      cmake \
      socat \
      htop \
      binutils \
      neofetch \
      ctags \
      locales \
      locales-all \
      nodejs \
      npm \
      binwalk \
      sqlmap \
      dirb \
      qemu \
      httpie \
      valgrind

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 2
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2 1
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

WORKDIR /tmp
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN git clone https://github.com/keystone-engine/keystone.git
RUN cd keystone && mkdir build && cd build && ../make-share.sh && make install \
      && cd ../bindings/python/ && make install3
RUN rm -rf /tmp/*

ENV TERM xterm-256color
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV UID="1000"
ENV UNAME="ctf"
ENV GID="1000"
ENV GNAME="ctf"
ENV SHELL="/bin/zsh"
ENV UHOME="/home/ctf"

RUN useradd --create-home --home-dir ${UHOME} -s ${SHELL} -u ${GID} ${UNAME} \
      && chown -R ${UNAME}:${UNAME} ${UHOME}
RUN echo "${UNAME}:toor" | chpasswd && adduser ${UNAME} sudo 
USER ${UNAME}
WORKDIR ${UHOME}

COPY config/requirements.txt .
RUN pip install -r requirements.txt
RUN rm requirements.txt
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
COPY config/zshrc .zshrc
COPY config/tmux.conf .tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
RUN mkdir .config
COPY config/nvim .config/nvim
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qall > /dev/null
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

ENTRYPOINT ["/bin/zsh"]
