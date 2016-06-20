FROM ubuntu:16.04

# Ubuntu updates
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

ENV DOCKERBIND_VERSION 1
ENV DATA_DIR=/data
ENV BIND_USER=bind

RUN apt-get update && apt-get install -y bind9 perl dnsutils

#COPY overlay/ /

EXPOSE 53/udp 53/tcp 953/tcp
VOLUME ["/data"]

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]

#CMD ["/usr/sbin/named"]

