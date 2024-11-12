# Usage:
#   docker build -t akb74/make-tests .
#   docker run -it -v .:/git/host akb74/make-tests
#   ./make check-regression

# Note this gives a couple of failures 
#   features/output-sync 
#   features/temp_stdin 

FROM ubuntu:jammy

RUN echo "## Start building" \
    && echo "## Update and install packages" \
    && apt-get -qq -y update \
    && apt-get -qq install -y --no-install-recommends \
        binutils \
        build-essential \
        ca-certificates \
        curl \
        file \
        git \
        python3 \
        python3-pip \
        tar \
    && echo "## Done"

ARG MAKE_VERSION=4.4.1    

WORKDIR /git
RUN curl https://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.gz -o make-${MAKE_VERSION}.tar.gz --fail-with-body
RUN tar -xvzf make-${MAKE_VERSION}.tar.gz
RUN mv make-${MAKE_VERSION} make

WORKDIR /git/make
RUN ./configure
RUN make

# Remove existing regular build of make
RUN which make | xargs -d '\n' rm -rf

WORKDIR /git/make

CMD ["bash"]
