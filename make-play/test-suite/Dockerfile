# Usage:
#   docker build -t make .
#   docker run -it make
#   ./make check-regression

FROM ubuntu:jammy

# Install the packages needed to get and build GNU Make
RUN echo "## Start building" \
    && echo "## Update and install packages" \
    && apt-get -qq -y update \
    && apt-get -qq install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        tar \
    && echo "## Done"

# Define which version of GNU Make we'd like to work with
ARG MAKE_VERSION=4.4.1

# Get and untar GNU Make
WORKDIR /root
RUN curl https://ftp.gnu.org/gnu/make/make-${MAKE_VERSION}.tar.gz -o make-${MAKE_VERSION}.tar.gz --fail-with-body
RUN tar -xvzf make-${MAKE_VERSION}.tar.gz
RUN mv make-${MAKE_VERSION} make

# Build GNU Make
WORKDIR /root/make
RUN ./configure
RUN make

# Remove existing regular build of make
RUN which make | xargs -d '\n' rm -rf

CMD ["bash"]
