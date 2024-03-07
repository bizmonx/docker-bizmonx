FROM --platform=linux/amd64 debian:latest

RUN apt-get update && apt-get install -y \
    rrdtool build-essential librrd-dev gcc wget procps \
    libpcre3 libpcre3-dev libssl-dev zlib1g-dev openssl \
    apache2 vim less net-tools neovim curl wget

WORKDIR /opt/zig
RUN wget https://ziglang.org/builds/zig-linux-x86_64-0.12.0-dev.3160+aa7d16aba.tar.xz && \
    tar xf zig-linux-x86_64-0.12.0-dev.3160+aa7d16aba.tar.xz && \
    ln -sf ./zig-linux-x86_64-0.12.0-dev.3160+aa7d16aba current && \
    ln -sf /opt/zig/current/zig /usr/local/sbin/zig && \
    rm -rf zig-linux-x86_64-0.12.0-dev.3160+aa7d16aba.tar.xz

RUN useradd -s /bin/bash -M xymon && mkdir /home/xymon && chown -R xymon:xymon /home/xymon

RUN mkdir /home/build && wget https://kumisystems.dl.sourceforge.net/project/xymon/Xymon/4.3.30/xymon-4.3.30.tar.gz \
    && tar -xvf xymon-4.3.30.tar.gz -C /home/build \
    && cd /home/build/xymon-4.3.30

ADD Makefile /home/build/xymon-4.3.30/Makefile


RUN cd /home/build/xymon-4.3.30 && chmod +rx /home/xymon -R && make && make install

RUN cp /home/xymon/server/etc/xymon-apache.conf /etc/apache2/conf-available/ && \
    ln -sf /etc/apache2/conf-available/xymon-apache.conf \ 
    /etc/apache2/conf-enabled/xymon-apache.conf

RUN a2enmod rewrite && a2enmod cgi

ADD ./scripts /home/xymon/scripts

#USER xymon

 

