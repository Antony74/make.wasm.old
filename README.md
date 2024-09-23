    docker build -t akb74/make.wasm .
    docker run -it -v .:/build/output akb74/make.wasm 


    docker run -it -v .:/src -w /src ghcr.io/webassembly/wasi-sdk sh
