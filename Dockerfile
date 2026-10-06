FROM debian:stable-slim
# same as https://github.com/Niema-Docker/cse185_code/blob/main/Dockerfile but with `sudo -H` and `sudo` removed
RUN apt-get update && \
    # install general dependencies
    apt-get install -y --no-install-recommends bc bison bzip2 cmake flex git libboost-all-dev libbz2-dev libcurl4-openssl-dev libeigen3-dev liblzma-dev g++ gcc git make perl-doc python-is-python3 python3 python3-pip unzip xz-utils zlib1g-dev && \
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib && \

    # install Python packages
    pip3 install --break-system-packages --upgrade networkx niemads phylo-treetime scikit-learn setuptools treeswift && \

    # install htslib
    wget -qO- "https://github.com/samtools/htslib/releases/download/1.24/htslib-1.24.tar.bz2" | tar -xj && \
    cd htslib-* && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf htslib-* && \

    # install Bowtie2
    wget "https://github.com/BenLangmead/bowtie2/releases/download/v2.5.5/bowtie2-2.5.5-linux-x86_64.zip" && \
    unzip bowtie2-*.zip && \
    mv bowtie2-*/bowtie2* /usr/local/bin/ && \
    rm -rf bowtie2-* && \

    # install BWA
    wget -qO- "https://github.com/lh3/bwa/archive/refs/tags/v0.7.19.tar.gz" | tar -zx && \
    cd bwa-* && \
    make && \
    mv bwa /usr/local/bin/bwa && \
    cd .. && \
    rm -rf bwa-* && \

    # install fastp
    wget -qO /usr/local/bin/fastp "http://opengene.org/fastp/fastp.1.3.7" && \
    chmod a+x /usr/local/bin/fastp && \

    # install FastTree
    wget "http://www.microbesonline.org/fasttree/FastTree.c" && \
    gcc -DUSE_DOUBLE -DOPENMP -fopenmp -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm && \
    mv FastTree /usr/local/bin && \
    rm FastTree.c && \

    # install freebayes
    wget -qO- "https://github.com/freebayes/freebayes/releases/download/v1.3.10/freebayes-1.3.10-linux-amd64-static.gz" | gunzip > freebayes && \
    chmod a+x freebayes && \
    mv freebayes /usr/local/bin/ && \

    # install HISAT2
    wget -qO- "https://github.com/DaehwanKimLab/hisat2/archive/refs/tags/v2.2.3.tar.gz" | tar -zx && \
    cd hisat2-* && \
    make && \
    mv hisat2 hisat2-* *.py /usr/local/bin/ && \
    cd .. && \
    rm -rf hisat2-* && \

    # install IQ-TREE 3
    wget -qO- "https://github.com/iqtree/iqtree3/releases/download/v3.1.4/iqtree-3.1.4-Linux.tar.gz" | tar -zx && \
    mv iqtree-*/bin/* /usr/local/bin/ && \
    rm -rf iqtree-* && \

    # install kallisto
    wget -qO- "https://github.com/pachterlab/kallisto/releases/download/v0.52.0/kallisto_linux-v0.52.0.tar.gz" | tar -zx && \
    mv kallisto/kallisto /usr/local/bin/kallisto && \
    rm -rf kallisto && \

    # install LoFreq
    wget -qO- "https://github.com/CSB5/lofreq/raw/refs/heads/master/dist/lofreq_star-2.1.5_linux-x86-64.tgz" | tar -zx && \
    mv lofreq_star-*/bin/* /usr/local/bin/ && \
    rm -rf lofreq_star-* && \

    # install LSD2
    wget -qO /usr/local/bin/lsd2 "https://github.com/tothuhien/lsd2/releases/download/v.2.4.1/lsd2_unix" && \
    chmod a+x /usr/local/bin/lsd2 && \

    # install MAFFT
    wget "https://mafft.cbrc.jp/alignment/software/mafft_7.526-1_amd64.deb" && \
    dpkg -i mafft_*.deb && \
    rm -rf mafft* && \

    # install Minimap2
    wget -qO- "https://github.com/lh3/minimap2/releases/download/v2.31/minimap2-2.31_x64-linux.tar.bz2" | tar -xj && \
    mv minimap2-*/minimap2 /usr/local/bin/minimap2 && \
    rm -rf minimap2-* && \

    # install newick_utils
    wget -qO- "https://github.com/Niema-Docker/newick-utils/raw/refs/heads/main/newick-utils-1.6-Linux-x86_64-disabled-extra.tar.gz" | tar -zx && \
    mv newick-utils-*/src/nw_* /usr/local/bin/ && \
    rm -rf newick-utils-* && \

    # install Prodigal
    wget -qO /usr/local/bin/prodigal "https://github.com/hyattpd/Prodigal/releases/download/v2.6.3/prodigal.linux" && \
    chmod a+x /usr/local/bin/prodigal && \

    # install Quack
    wget -qO- "https://github.com/IGBB/quack/archive/refs/tags/v2.0.tar.gz" | tar -zx && \
    cd quack-* && \
    git clone https://github.com/attractivechaos/klib.git && \
    make quack && \
    mv quack /usr/local/bin/ && \
    cd .. && \
    rm -rf quack-* && \

    # install QUAST
    wget -qO- "https://github.com/ablab/quast/releases/download/quast_5.3.0/quast-5.3.0.tar.gz" | tar -zx && \
    cd quast-* && \
    python3 setup.py install && \
    cd .. && \
    rm -rf quast-* && \

    # install rammap
    wget -qO /usr/local/bin/rammap "https://github.com/jwanglab/rammap/releases/download/v1.1.3/rammap_x86_64-unknown-linux-gnu_v1.1.3" && \
    chmod a+x /usr/local/bin/rammap && \

    # install RAxML-NG
    mkdir -p raxml && \
    cd raxml && \
    wget "https://github.com/amkozlov/raxml-ng/releases/download/2.0.3/raxml-ng_v2.0.3_linux_x86_64.zip" && \
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
    wget -qO- "https://github.com/COMBINE-lab/salmon/releases/download/v2.8.0/salmon-cli-x86_64-unknown-linux-gnu.tar.xz" | tar -Jx && \
    mv salmon-*/salmon /usr/local/bin/ && \
    rm -rf salmon-* && \

    # install samtools
    wget -qO- "https://github.com/samtools/samtools/releases/download/1.24/samtools-1.24.tar.bz2" | tar -xj && \
    cd samtools-* && \
    ./configure --prefix=/usr/local --without-curses && \
    make && \
    make install && \
    cd .. && \
    rm -rf samtools-* && \

    # install SPAdes
    wget -qO- "https://github.com/ablab/spades/releases/download/v4.3.0/SPAdes-4.3.0-Linux.tar.gz" | tar -zx && \
    mv SPAdes-*/bin/* /usr/local/bin/ && \
    mv SPAdes-*/share/* /usr/local/share/ && \
    rm -rf SPAdes-* && \

    # install STAR
    wget "https://github.com/alexdobin/STAR/releases/download/2.7.11b/STAR_2.7.11b.zip" && \
    unzip STAR_*.zip && \
    mv STAR_*/Linux_x86_64_static/* /usr/local/bin/ && \
    rm -rf STAR_* && \

    # install tn93
    wget -qO- "https://github.com/veg/tn93/archive/refs/tags/v1.0.17.tar.gz" | tar -zx && \
    cd tn93-* && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ . && \
    make && \
    make install && \
    cd .. && \
    rm -rf tn93-* && \

    # install TreeCluster
    wget -qO- "https://github.com/niemasd/TreeCluster/archive/refs/tags/1.0.5.tar.gz" | tar -zx && \
    mv TreeCluster-*/TreeCluster.py /usr/local/bin/ && \
    rm -rf TreeCluster-* && \

    # install ViralConsensus
    wget -qO- "https://github.com/niemasd/ViralConsensus/archive/refs/tags/1.0.4.tar.gz" | tar -zx && \
    cd ViralConsensus-* && \
    make && \
    mv viral_consensus /usr/local/bin/viral_consensus && \
    cd .. && \
    rm -rf ViralConsensus-* && \

    # install ViralMSA
    wget -qO /usr/local/bin/ViralMSA.py "https://github.com/niemasd/ViralMSA/releases/download/1.1.49/ViralMSA.py" && \
    chmod a+x /usr/local/bin/ViralMSA.py && \

    # clean up
    apt-get autoremove -y && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib""
