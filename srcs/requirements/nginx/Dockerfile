FROM debian:11

RUN apt-get update
RUN apt-get install -y nginx openssl

RUN mkdir -p /var/www/
RUN mkdir -p /etc/nginx/ssl/

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/dcandeia.crt -keyout /etc/nginx/ssl/dcandeia.key -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=dcandeia/CN=dcandeia/"

CMD ["tail", "-f", "/dev/null"]

