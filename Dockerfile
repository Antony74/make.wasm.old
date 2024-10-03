ARG EMSCRIPTEN_VERSON=3.1.67

FROM emscripten/emsdk:${EMSCRIPTEN_VERSON}

ARG MAKE_VERSION=4.4.1

RUN apt-get update
RUN apt-get install curl
RUN apt-get install tar

WORKDIR /build

RUN curl https://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.gz -o make-${MAKE_VERSION}.tar.gz --fail-with-body
RUN tar -xvzf make-${MAKE_VERSION}.tar.gz
RUN mv make-${MAKE_VERSION} make

WORKDIR /build/make

RUN emconfigure ./configure
RUN emmake make
RUN find . -name "*.o" -type f | xargs emcc -O2 -o make.js

WORKDIR /build

COPY docker-wasm-build/clean-and-copy-to-host.sh .

CMD ["sh", "./clean-and-copy-to-host.sh"]
