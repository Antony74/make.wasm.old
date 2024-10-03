set -e

cd host
ls --hide docker-wasm-build --hide Dockerfile | xargs -d '\n' rm -rf
cp ../make .
