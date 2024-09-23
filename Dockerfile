FROM ghcr.io/webassembly/wasi-sdk:sha-adbbf2c

ARG MAKE_VERSION=4.4.1

RUN apt-get update
RUN apt-get install curl
RUN apt-get install tar

WORKDIR /build

RUN curl https://ftp.gnu.org/gnu/make/make-$MAKE_VERSION.tar.gz -o make-$MAKE_VERSION.tar.gz --fail-with-body

RUN tar -xvzf make-${MAKE_VERSION}.tar.gz

WORKDIR /build/make-${MAKE_VERSION}

# ENV CFLAGS="-O3 --target=wasm32 -nostdlib"
# ENV LDFLAGS="--target=wasm32 -Wl,--no-entry -Wl,--export-all"
# ENV CC="clang --target=wasm32"
# ENV CXX="clang++ --target=wasm32"

RUN ./configure --host=wasm32 target=wasm32

# RUN make
