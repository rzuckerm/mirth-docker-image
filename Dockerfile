FROM ubuntu:24.04

COPY MIRTH_* /tmp/
RUN apt-get update && \
    apt-get install -y git make gcc && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/mirth-lang/mirth && \
    cd mirth && \
    git reset --hard $(cat /tmp/MIRTH_COMMIT_HASH) && \
    make && \
    make install && \
    cd / && \
    apt-get remove -y git make && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /opt/mirth /var/lib/apt/lists/*
ENV PATH="/root/.mirth/bin:${PATH}"
