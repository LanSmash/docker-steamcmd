FROM ubuntu:16.04
#MAINTAINER SteamCache.Net Team <team@steamcache.net>

# Ubuntu updates
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

ENV DOCKERBIND_VERSION 1
ENV DATA_DIR=/data
ENV BIND_USER=bind

RUN apt-get update && apt-get install -y bind9 perl dnsutils

#COPY overlay/ /

EXPOSE 53/udp 53/tcp
VOLUME ["/data"]

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]


#CMD ["/usr/sbin/named"]


#RUN	chmod 755 /scripts/*			;\
#	mkdir -m 755 -p /data/cache		;\
#	mkdir -m 755 -p /data/info		;\
#	mkdir -m 755 -p /data/logs		;\
#	mkdir -m 755 -p /tmp/nginx/		;\
#	chown -R ${WEBUSER}:${WEBUSER} /data/	;\
#	mkdir -p /etc/nginx/sites-enabled	;\
#	ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf ;\
#	mkdir -p /var/www ;\
#	chmod 777 /var/www ;\
#	echo hi >> /var/www/index.html
#       ln -s /etc/nginx/sites-available/generic.conf /etc/nginx/sites-enabled/generic.conf
	

#VOLUME ["/data/logs", "/data/cache", "/var/www"]

#EXPOSE 80

#WORKDIR /scripts

#ENTRYPOINT ["/scripts/bootstrap.sh"]
