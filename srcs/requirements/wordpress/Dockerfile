FROM debian:oldstable

RUN apt update && apt install -y \
    curl               \
    php7.4             \
    php7.4-fpm         \
    php7.4-mysql       \
    php7.4-curl        \
    php7.4-gd          \
    php7.4-mbstring    \
    php7.4-xml         \
    php7.4-xmlrpc      \
    php7.4-soap        \
    php7.4-intl        \
    php7.4-zip

# HO-MY-ZSH INSTALLATION
RUN apt-get install -y git
RUN apt-get install -y zsh
RUN apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install.sh
RUN chmod +x /tmp/install.sh
RUN /tmp/install.sh -y
RUN rm /tmp/install.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar

# Move wp-cli.phar worpress executable to /bin folder and changed her name to wordpress
# Now I can use wordpress like an ls or cat command 
RUN mv wp-cli.phar /usr/local/bin/wordpress

RUN mkdir /run/php/ && chmod 755 /run/php/
RUN sed -i 's+listen = /run/php/php7.4-fpm.sock+listen = 9000+g' /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/42_wordpress_configs.sh /home
RUN chmod +x /home/42_wordpress_configs.sh

EXPOSE 9000

ENTRYPOINT ["/home/42_wordpress_configs.sh"]

CMD ["php-fpm7.4", "-F", "-R"]