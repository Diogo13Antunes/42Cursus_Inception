#!/bin/bash

command=0
attempts=0
max_attempts=5

wp_download()
{
	if wordpress core download --allow-root; 
	then
		((command+=1))
	fi
	echo "Here Download"
}

wp_config() 
{
	if wordpress config create \
		--allow-root \
		--path=/var/www/html/ \
		--dbname=$MARIADB_DATABASE_NAME \
		--dbuser=$MARIADB_DATABASE_ADMIN \
		--dbpass=$MARIADB_DATABASE_ADMIN_PASS \
		--dbhost=$MARIADB_DATABASE_HOST
	then
		((command+=1))
	fi
	echo "Here Config"
}

wp_install()
{
	if wordpress core install    \
		--allow-root \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN_NAME \
		--admin_password=$WORDPRESS_ADMIN_PASS \
		--admin_email=$WORDPRESS_ADMIN_EMAIL \
		--url=$DOMAIN
	then
		wordpress user create \
		--allow-root \
		$WORDPRESS_EXAMPLE_USER_NAME $WORDPRESS_EXAMPLE_USER_EMAIL \
		--user_pass=$WORDPRESS_EXAMPLE_USER_PASS
		((command+=1))
	fi
	echo "Here Install"
}

sleep 3

conf_file="/var/www/html/wp-config.php"

if [ ! -e "$conf_file" ]; then

	cd /var/www/html/

	while [ $attempts -le $max_attempts ]; do

		if [ $command -eq 0 ]; then
			wp_download
		fi
		echo "Valor do Commands -> " $command
		if [ $command -eq 1 ]; then
			wp_config
		fi
		if [ $command -eq 2 ]; then
			wp_install
		fi
		if [ $command -ge 3 ]; then
			break
		fi
		((attempts+=1))

		sleep 1

	done

	if [ $attempts -ge $max_attempts ]; then
		echo "Failed to install WordPress."
	else
		echo "WordPress installation successfully."
	fi

else
	echo "Wordpress already installed and ready to use."
fi

exec "$@"
