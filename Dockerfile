FROM debian:stable-slim

LABEL mantainer="yuanzheng"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Shanghai

ADD conf.ini /root/cloud/conf.ini
ADD aria2.conf /root/aria2/aria2.conf
ADD trackers-list-aria2.sh /root/aria2/trackers-list-aria2.sh
ADD run.sh /root/cloud/run.sh

RUN apt update \
    && apt install wget curl aria2 -y

RUN wget -qO cloud.tar.gz https://github.com/womade/4S-YUN/raw/main/cloud_linux_amd64.tar.gz \
    && wget -qO /root/aria2/dht.dat https://github.com/womade/4S-YUN/raw/main/dht.dat \
    && wget -qO /root/aria2/dht6.dat https://github.com/womade/4S-YUN/raw/main/dht6.dat

# RUN wget -qO cloud.tar.gz https://github.com/cloudreve/Cloudreve/releases/download/3.3.2/cloudreve_3.3.2_linux_amd64.tar.gz \
#     && wget -qO /root/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat \
#     && wget -qO /root/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat

RUN tar -zxvf cloud.tar.gz -C /root/cloud
RUN touch /root/aria2/aria2.session /root/aria2/aria2.log
RUN chmod +x /root/cloud/cloudreve \
    && chmod +x /root/aria2/trackers-list-aria2.sh \
    && chmod +x /root/cloud/run.sh

RUN mkdir -p /root/Downloads

ENTRYPOINT ["sh", "/root/cloud/run.sh"]
