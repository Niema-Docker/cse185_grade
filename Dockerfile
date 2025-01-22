FROM debian:12.2-slim
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>
RUN apt-get update && \
    # install general dependencies
    apt-get install -y --no-install-recommends bison bzip2 cmake flex libboost-all-dev libbz2-dev libcurl4-openssl-dev libeigen3-dev libgsl-dev liblzma-dev g++ gcc git make python3 python3-pip unzip wget zlib1g-dev && \

    # install htslib
    wget -qO- "https://github.com/samtools/htslib/releases/download/1.21/htslib-1.21.tar.bz2" | tar -xj && \
    cd htslib-* && \
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
    wget -O /usr/local/bin/quack "https://github.com/IGBB/quack/releases/download/1.2.1/linux.quack" && \
    chmod a+x /usr/local/bin/quack && \

    # install QUAST
    wget -qO- "https://github.com/ablab/quast/releases/download/quast_5.3.0/quast-5.3.0.tar.gz" | tar -zx && \
    cd quast-* && \
    python3 setup.py install && \
    cd .. && \
    rm -rf quast-* && \

    # install SPAdes
    wget -qO- "https://github.com/ablab/spades/releases/download/v4.0.0/SPAdes-4.0.0-Linux.tar.gz" | tar -zx && \
    mv SPAdes-*/bin/* /usr/local/bin/ && \
    mv SPAdes-*/share/* /usr/local/share/ && \
    rm -rf SPAdes-* && \

    # clean up
    apt-get autoremove -y && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*
