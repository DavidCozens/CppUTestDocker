FROM gcc:14
LABEL Description="Image for running CppUTest"

RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf automake libtool git cmake gdb clang-format \
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

WORKDIR /home/src
