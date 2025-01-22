FROM alpine:3.13.5
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>
RUN apk update && \
    # install general dependencies
    apk add --no-cache autoconf automake bash bzip2-dev curl-dev g++ git gsl-dev make py3-pip py3-setuptools python3 xz-dev zlib-dev && \

    # install htslib
    wget -qO- "https://github.com/samtools/htslib/releases/download/1.21/htslib-1.21.tar.bz2" | tar -xj && \
    cd htslib-* && \
    autoreconf -i && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf htslib-* && \

    # install ART
    wget -qO- "https://www.niehs.nih.gov/sites/default/files/2024-02/artsrcmountrainier2016.06.05linux.tgz" | tar -zx && \
    cd art_* && \
    make clean && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf art_* && \

    # install Quack
    git clone --recursive "https://github.com/IGBB/quack.git" && \
    cd quack && \
    make && \
    mv quack /usr/local/bin/quack && \
    cd .. && \
    rm -rf quack && \

    # install QUAST
    wget -qO- "https://github.com/ablab/quast/releases/download/quast_5.3.0/quast-5.3.0.tar.gz" | tar -zx && \
    cd quast-* && \
    python3 setup.py install && \
    cd .. && \
    rm -rf quast-* && \

    # clean up
    rm -rf /var/cache/apk/*
