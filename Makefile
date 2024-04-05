# Containers Names
MARIADB		= 42_mariadb
NGINX		= 42_nginx
WORDPRESS	= 42_wordpress

# Docker Compose
COMPOSE		= sudo docker compose -f srcs/docker-compose.yml
DOCKER		= sudo docker

include srcs/.env

.SILENT:

all:
	sudo mkdir -p $(VOLUMES_DATA)/data/mysql $(VOLUMES_DATA)/data/wordpress;

	$(COMPOSE) up -d

start:
	$(COMPOSE) up -d

stop:
	$(COMPOSE) stop

clean:
	$(COMPOSE) down --rmi all --volumes

clean-all: clean
	cd ./ && sudo rm -irf $(VOLUMES_DATA)/data

re: clean all

logs:
	$(COMPOSE) logs

info:
	echo "-------------------------------------------------------------------------------------------------"
	$(COMPOSE) ps -a
	echo "-------------------------------------------------------------------------------------------------"
	$(DOCKER) images
	echo "-------------------------------------------------------------------------------------------------"
	$(DOCKER) network ls
	echo "-------------------------------------------------------------------------------------------------"
	$(DOCKER) volume ls
	echo "-------------------------------------------------------------------------------------------------"

# Entrar no modo interativo de cada container
mariadb-it:
	$(DOCKER) exec -it $(MARIADB) /bin/bash

nginx-it:
	$(DOCKER) exec -it $(NGINX) /bin/bash

wordpress-it:
	$(DOCKER) exec -it $(WORDPRESS) /bin/bash
