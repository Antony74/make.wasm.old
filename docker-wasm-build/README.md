
    docker build -t akb74/make.wasm .
    docker run -it -v .:/build/host akb74/make.wasm