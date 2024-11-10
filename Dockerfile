# Usage:
#     docker build -t akb74/make.wasm .
#     docker run -it -v .:/build/host akb74/make.wasm
#
# Other commands I find helpful:
#     docker run -it -v .:/build/host akb74/make.wasm bash

ARG EMSCRIPTEN_VERSON=3.1.71

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

COPY docker-wasm-build/package.json .

# Switch to the wasm build of make.  If you want to bootstrap from the regular binary build of make, comment from here

# # Remove existing regular build of make
# RUN which make | xargs -d '\n' rm -rf

# COPY make.wasm .
# COPY make.js .

# RUN npm install --global .

# If you want to bootstrap from the regular binary build of make, comment to here

RUN CFLAGS="-DUSE_POSIX_SPAWN" emconfigure ./configure
RUN emmake make
RUN emcc -O2 -s NODERAWFS=1 -o make.js $(find . -name "*.o")
RUN sed -i '1s/^/#!\/usr\/bin\/env node\n/' make.js

# Remove existing regular build of make, and install the one we just built
RUN which make | xargs -d '\n' rm -rf
RUN npm install --global .

WORKDIR /build

COPY docker-wasm-build/clean-and-copy-to-host.sh .

# make-play just some useful test code here

COPY make-play ./make-play
WORKDIR /build/make-play

CMD ["sh", "./clean-and-copy-to-host.sh"]
