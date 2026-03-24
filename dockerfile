FROM gcc:14
LABEL Description="Image for running CppUTest"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf automake clang-format clang-tidy cmake gdb git lcov libtool nodejs sudo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/cpputest
RUN git clone --depth 1 --branch v4.0 https://github.com/cpputest/cpputest.git . \
 && autoreconf . -i \
 && ./configure \
 && make install

ENV CPPUTEST_HOME=/home/cpputest

WORKDIR /home/legacy-build
RUN git clone https://github.com/jwgrenning/legacy-build.git . \
 && git submodule update --init \
 && bash test/all-tests.sh

ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN mkdir -p /home/src \
    && groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} --create-home ${USERNAME} \
    && echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && chown -R ${USERNAME}:${USERNAME} /home/cpputest /home/legacy-build /home/src

USER ${USERNAME}

WORKDIR /home/src
