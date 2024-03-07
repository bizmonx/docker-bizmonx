FROM --platform=linux/amd64 debian:latest

RUN apt-get update && apt-get install -y \
    rrdtool build-essential librrd-dev gcc wget procps \
    libpcre3 libpcre3-dev libssl-dev zlib1g-dev openssl \
    apache2 vim less net-tools

RUN useradd -s /bin/bash -M xymon && groupadd xymon && usermod -a -G xymon xymon && chown -R xymon:xymon /home/xymon

RUN mkdir /home/build && wget https://kumisystems.dl.sourceforge.net/project/xymon/Xymon/4.3.30/xymon-4.3.30.tar.gz \
    && tar -xvf xymon-4.3.30.tar.gz -C /home/build \
    && cd /home/build/xymon-4.3.30

ADD Makefile /home/build/xymon-4.3.30/Makefile

RUN cd /home/build/xymon-4.3.30 && make && make install

