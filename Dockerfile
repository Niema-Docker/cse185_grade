FROM alpine:3.13.5
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>
RUN apk update && \
    # install general dependencies
    apk add --no-cache autoconf automake bash bzip2-dev curl-dev g++ git make python3 xz-dev zlib-dev && \

    # install htslib
    wget -qO- "https://github.com/samtools/htslib/releases/download/1.21/htslib-1.21.tar.bz2" | tar -xj && \
    cd htslib-* && \
    autoreconf -i && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf htslib-* && \

    # install Quack
    wget -O /usr/local/bin/quack "https://github.com/IGBB/quack/releases/download/1.2.1/linux.quack" && \
    chmod a+x /usr/local/bin/quack && \

    # clean up
    rm -rf /var/cache/apk/*
