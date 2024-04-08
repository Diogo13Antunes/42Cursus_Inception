FROM debian:oldstable

RUN apt-get update
RUN apt-get install -y mariadb-server

# HO-MY-ZSH INSTALLATION
RUN apt-get install -y git
RUN apt-get install -y zsh
RUN apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install.sh
RUN chmod +x /tmp/install.sh
RUN /tmp/install.sh -y
RUN rm /tmp/install.sh

COPY ./tools/42_mariadb_configs.sh /home

RUN chmod +x /home/42_mariadb_configs.sh

RUN mysql_install_db

EXPOSE 3306

ENTRYPOINT ["/home/42_mariadb_configs.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
