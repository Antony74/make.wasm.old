set -e
set -x

cd host
ls --hide docker-wasm-build --hide .gitignore --hide make-play | xargs -d '\n' rm -rf
cp -a ../make/. ./
