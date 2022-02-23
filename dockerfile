FROM davidcozens/googletest:4
LABEL Description="Image for running CppUTest"
WORKDIR /home/cpputest

RUN git clone --depth 1 --branch v4.0 https://github.com/cpputest/cpputest.git . \
 && autoreconf . -i \
 && ./configure  --enable-gmock\
 && make install

ENV CPPUTEST_HOME=/home/cpputest

WORKDIR /home/legacy-build
RUN git clone https://github.com/jwgrenning/legacy-build.git . \
 && git submodule update --init \
 && bash test/all-tests.sh

WORKDIR /home/src