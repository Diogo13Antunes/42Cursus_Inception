FROM debian:11

RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y mariadb-server

# COPY ./tools/configs_mdb.sh /home
COPY ./tools/configs_mdb.py /home

# RUN chmod +x /home/configs_mdb.sh

RUN mysql_install_db

EXPOSE 3306

# ENTRYPOINT ["/home/configs_mdb.sh"]
CMD ["python3", "/home/configs_mdb.py"]

#CMD ["mysqld", "--bind-address=0.0.0.0"]
