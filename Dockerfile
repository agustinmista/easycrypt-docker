FROM ubuntu:22.04 AS base

SHELL ["/bin/bash", "-c"]

# ----------------------------------------
# Install system dependencies

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install sudo autoconf opam emacs libgmp-dev libpcre3-dev pkg-config zlib1g-dev

# ----------------------------------------
# Move into userland

ARG USER_NAME=easycrypt
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o $USER_NAME
RUN useradd -m -u $UID -g $GID -G sudo -o -s /bin/bash -d /home/$USER_NAME $USER_NAME
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $USER_NAME
WORKDIR /home/$USER_NAME/

# ----------------------------------------
# Install Z3

ARG Z3_REPO=https://github.com/Z3Prover/z3
ARG Z3_TAG=z3-4.8.10
ARG Z3_PREBUILD=z3-4.8.10-x64-ubuntu-18.04
ARG Z3_SRC=$Z3_REPO/releases/download/$Z3_TAG/$Z3_PREBUILD.zip

RUN wget --quiet $Z3_SRC -O z3.tar.gz && \
    unzip -q z3.tar.gz -d z3 && \
    rm z3.tar.gz && \
    mv z3/$Z3_PREBUILD/* z3 && \
    rmdir z3/$Z3_PREBUILD

ENV PATH="/home/$USER_NAME/z3/bin:${PATH}"
RUN echo "export PATH=$PATH" >> ~/.bashrc

# ----------------------------------------
# Initialize opam

ARG OPAM_SWITCH=4.12.1

RUN opam init -a --disable-sandboxing && \
    opam switch create $OPAM_SWITCH

ENV PATH="/home/$USER_NAME/.opam/$OPAM_SWITCH/bin:${PATH}"
RUN echo "export PATH=$PATH" >> ~/.bashrc

# ----------------------------------------
# Install alt-ergo

ARG ALT_ERGO_VERSION=2.4.1

RUN eval $(opam env) && \
    opam pin alt-ergo $ALT_ERGO_VERSION -y && \
    opam install alt-ergo -y

# ----------------------------------------
# Install EasyCrypt

ARG EASYCRYPT_REPO=https://github.com/EasyCrypt/easycrypt.git

RUN eval $(opam env) && \
    opam pin -yn add easycrypt $EASYCRYPT_REPO && \
    opam install easycrypt -y

RUN easycrypt why3config

# ----------------------------------------
# Copy some necessary files

COPY --chown=$USER_NAME:$USER_NAME check-install.ec check-install.ec

# ----------------------------------------
# Ensure that everything works

RUN easycrypt check-install.ec

RUN mkdir /home/$USER_NAME/.doom.d
COPY --chown=$USER_NAME:$USER_NAME doom-config/packages.el /home/$USER_NAME/.doom.d/packages.el
COPY --chown=$USER_NAME:$USER_NAME doom-config/init.el /home/$USER_NAME/.doom.d/init.el
COPY --chown=$USER_NAME:$USER_NAME doom-config/config.el /home/$USER_NAME/.doom.d/config.el
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d

# ----------------------------------------
# Configure Emacs with Proof General and Evil mode

RUN yes | ~/.emacs.d/bin/doom install

# ----------------------------------------
# Change the working directory and the entry point to emacs with better color support

WORKDIR /home/$USER_NAME/workdir

ENV TERM=xterm-256color

ENTRYPOINT ["/usr/bin/emacs"]
