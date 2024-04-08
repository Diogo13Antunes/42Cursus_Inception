FROM debian:oldstable

RUN apt-get update
RUN apt-get install -y nginx openssl

RUN mkdir -p /var/www /run/nginx /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/dcandeia.crt -keyout /etc/nginx/ssl/dcandeia.key -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=dcandeia/CN=dcandeia/"

# HO-MY-ZSH INSTALLATION
RUN apt-get install -y git
RUN apt-get install -y zsh
RUN apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install.sh
RUN chmod +x /tmp/install.sh
RUN /tmp/install.sh -y
RUN rm /tmp/install.sh

COPY ./conf/nginx.conf /etc/nginx/conf.d

CMD [ "nginx", "-g", "daemon off;" ]
