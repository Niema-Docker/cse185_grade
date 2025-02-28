FROM debian:12.2-slim
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>
RUN apt-get update && \
    # install general dependencies
    apt-get install -y --no-install-recommends bison bzip2 cmake curl flex libboost-all-dev libbz2-dev libcurl4-openssl-dev libeigen3-dev libgsl-dev liblzma-dev g++ gcc git make perl-doc python-is-python3 python3 python3-pip unzip wget zlib1g-dev && \
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib && \

    # install Python packages
    pip3 install --break-system-packages networkx niemads phylo-treetime treeswift && \

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

    # install Bowtie2
    wget "https://github.com/BenLangmead/bowtie2/releases/download/v2.5.4/bowtie2-2.5.4-linux-x86_64.zip" && \
    unzip bowtie2-*.zip && \
    mv bowtie2-*/bowtie2* /usr/local/bin/ && \
    rm -rf bowtie2-* && \

    # install BWA
    wget -qO- "https://github.com/lh3/bwa/archive/refs/tags/v0.7.18.tar.gz" | tar -zx && \
    cd bwa-* && \
    make && \
    mv bwa /usr/local/bin/bwa && \
    cd .. && \
    rm -rf bwa-* && \

    # install fastp
    wget -O /usr/local/bin/fastp "http://opengene.org/fastp/fastp.0.24.0" && \
    chmod a+x /usr/local/bin/fastp && \

    # install FastTree
    wget "http://www.microbesonline.org/fasttree/FastTree.c" && \
    gcc -DUSE_DOUBLE -DOPENMP -fopenmp -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm && \
    mv FastTree /usr/local/bin && \
    rm FastTree.c && \

    # install freebayes
    wget -qO- "https://github.com/freebayes/freebayes/releases/download/v1.3.6/freebayes-1.3.6-linux-amd64-static.gz" | gunzip > freebayes && \
    chmod a+x freebayes && \
    mv freebayes /usr/local/bin/ && \

    # install HISAT2
    wget -O hisat2.zip "https://cloud.biohpc.swmed.edu/index.php/s/hisat2-220-Linux_x86_64/download" && \
    unzip hisat2*.zip && \
    mv hisat2-*/hisat2* /usr/local/bin/ && \
    mv hisat2-*/*.py /usr/local/bin/ && \
    rm -rf hisat2* && \

    # install IQ-TREE 2
    wget -qO- "https://github.com/iqtree/iqtree2/releases/download/v2.3.6/iqtree-2.3.6-Linux-intel.tar.gz" | tar -zx && \
    mv iqtree-*/bin/iqtree2 /usr/local/bin/iqtree2 && \
    rm -rf iqtree-* && \

    # install kallisto
    wget -qO- "https://github.com/pachterlab/kallisto/releases/download/v0.51.1/kallisto_linux-v0.51.1.tar.gz" | tar -zx && \
    mv kallisto/kallisto /usr/local/bin/kallisto && \
    rm -rf kallisto && \

    # install LoFreq
    wget -qO- "https://github.com/CSB5/lofreq/raw/refs/heads/master/dist/lofreq_star-2.1.5_linux-x86-64.tgz" | tar -zx && \
    mv lofreq_star-*/bin/* /usr/local/bin/ && \
    rm -rf lofreq_star-* && \

    # install LSD2
    wget -O /usr/local/bin/lsd2 "https://github.com/tothuhien/lsd2/releases/download/v.2.4.1/lsd2_unix" && \
    chmod a+x /usr/local/bin/lsd2 && \

    # install MAFFT
    wget "https://mafft.cbrc.jp/alignment/software/mafft_7.526-1_amd64.deb" && \
    dpkg -i mafft_*.deb && \
    rm -rf mafft* && \

    # install Minimap2
    wget -qO- "https://github.com/lh3/minimap2/releases/download/v2.28/minimap2-2.28_x64-linux.tar.bz2" | tar -xj && \
    mv minimap2-*/minimap2 /usr/local/bin/minimap2 && \
    rm -rf minimap2-* && \

    # install newick_utils
    wget -qO- "https://github.com/Niema-Docker/newick-utils/raw/refs/heads/main/newick-utils-1.6-Linux-x86_64-disabled-extra.tar.gz" | tar -zx && \
    mv newick-utils-*/src/nw_* /usr/local/bin/ && \
    rm -rf newick-utils-* && \

    # install Prodigal
    wget -O /usr/local/bin/prodigal "https://github.com/hyattpd/Prodigal/releases/download/v2.6.3/prodigal.linux" && \
    chmod a+x /usr/local/bin/prodigal && \

    # install Quack
    wget -O /usr/local/bin/quack "https://github.com/IGBB/quack/releases/download/1.2.1/linux.quack" && \
    chmod a+x /usr/local/bin/quack && \

    # install QUAST
    wget -qO- "https://github.com/ablab/quast/releases/download/quast_5.3.0/quast-5.3.0.tar.gz" | tar -zx && \
    cd quast-* && \
    python3 setup.py install && \
    cd .. && \
    rm -rf quast-* && \

    # install RAxML-NG
    mkdir -p raxml && \
    cd raxml && \
    wget "https://github.com/amkozlov/raxml-ng/releases/download/1.2.2/raxml-ng_v1.2.2_linux_x86_64.zip" && \
    unzip raxml*.zip && \
    mv raxml-ng /usr/local/bin/ && \
    cd .. && \
    rm -rf raxml && \

    # install RSEM
    wget -qO- "https://github.com/deweylab/RSEM/archive/refs/tags/v1.3.3.tar.gz" | tar -zx && \
    cd RSEM-* && \
    make && \
    make install && \
    cd .. && \
    rm -rf RSEM-* && \

    # install Salmon
    wget -qO- "https://github.com/COMBINE-lab/salmon/archive/refs/tags/v1.10.1.tar.gz" | tar -zx && \
    cd salmon-* && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ . && \
    make && \
    make install && \
    cd .. && \
    rm -rf salmon-* && \

    # install samtools
    wget -qO- "https://github.com/samtools/samtools/releases/download/1.21/samtools-1.21.tar.bz2" | tar -xj && \
    cd samtools-* && \
    ./configure --prefix=/usr/local --without-curses && \
    make && \
    make install && \
    cd .. && \
    rm -rf samtools-* && \

    # install SPAdes
    wget -qO- "https://github.com/ablab/spades/releases/download/v4.0.0/SPAdes-4.0.0-Linux.tar.gz" | tar -zx && \
    mv SPAdes-*/bin/* /usr/local/bin/ && \
    mv SPAdes-*/share/* /usr/local/share/ && \
    rm -rf SPAdes-* && \

    # install STAR
    wget "https://github.com/alexdobin/STAR/releases/download/2.7.11b/STAR_2.7.11b.zip" && \
    unzip STAR_*.zip && \
    mv STAR_*/Linux_x86_64_static/* /usr/local/bin/ && \
    rm -rf STAR_* && \

    # install tn93
    wget -qO- "https://github.com/veg/tn93/archive/refs/tags/v1.0.14.tar.gz" | tar -zx && \
    cd tn93-* && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ . && \
    make && \
    make install && \
    cd .. && \
    rm -rf tn93-* && \

    # install TreeCluster
    wget -qO- "https://github.com/niemasd/TreeCluster/archive/refs/tags/1.0.3.tar.gz" | tar -zx && \
    mv TreeCluster-*/TreeCluster.py /usr/local/bin/ && \
    rm -rf TreeCluster-* && \

    # install ViralConsensus
    wget -qO- "https://github.com/niemasd/ViralConsensus/archive/refs/tags/0.0.6.tar.gz" | tar -zx && \
    cd ViralConsensus-* && \
    make && \
    mv viral_consensus /usr/local/bin/viral_consensus && \
    cd .. && \
    rm -rf ViralConsensus-* && \

    # install ViralMSA
    wget -O /usr/local/bin/ViralMSA.py "https://github.com/niemasd/ViralMSA/releases/download/1.1.44/ViralMSA.py" && \
    chmod a+x /usr/local/bin/ViralMSA.py && \

    # clean up
    apt-get autoremove -y && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
