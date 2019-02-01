FROM alpine:latest
MAINTAINER Rudolf Potucek forked from Benedikt Lang <mail@blang.io>

RUN apk update \
    && apk add wget fontconfig perl \
    && rm -rf /var/cache/apk/* \
    && find / -name '*.pod' -exec rm -f {} \;

# Install TexLive with a minimal custom scheme
# following this article https://tex.stackexchange.com/questions/397174/minimal-texlive-installation
#
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
    mkdir /install-tl-unx; \
    tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1; \
    echo "selected_scheme scheme-custom" >> /install-tl-unx/texlive.profile; \
    echo "collection-basic 1"            >> /install-tl-unx/texlive.profile; \
    echo "collection-latex 1"            >> /install-tl-unx/texlive.profile; \
    echo "tlpdbopt_install_docfiles 0"   >> /install-tl-unx/texlive.profile; \
    echo "tlpdbopt_install_srcfiles 0"   >> /install-tl-unx/texlive.profile; \
    /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile; \
    rm -rf /install-tl-unx; \
    rm install-tl-unx.tar.gz

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linuxmusl:${PATH}"

ENV HOME /data
WORKDIR /data

# Install additional latex packages individually
RUN tlmgr install latexmk pageslts ms undolabl

VOLUME ["/data"]
