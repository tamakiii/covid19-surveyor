FROM ubuntu:18.04
MAINTAINER TAKANO Mitsuhiro
# @takano32 <takano32@gmail.com>

# RUN apt-get update

RUN apt-get update && apt-get install -y \
 make \
 wget \
 jq \
 nginx \
 fcgiwrap \
 squid \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ADD config/nginx_config /etc/nginx/sites-available/vscovid-crawler.conf
RUN ln -s /etc/nginx/sites-available/vscovid-crawler.conf /etc/nginx/sites-enabled/vscovid-crawler.conf

ADD config/squid.conf /etc/squid/squid.conf

# RUN apt-get -y install curl
# RUN apt-get -y install screen

EXPOSE 80
CMD ["bash"]
