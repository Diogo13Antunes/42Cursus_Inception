#!/bin/bash



if [ ! -d "/var/lib/mysql/$MARIADB_DATABASE_NAME" ]; then

service mariadb start

sleep 1

mysql_secure_installation << END

Y
$MARIADB_DATABASE_ROOT_PASS
$MARIADB_DATABASE_ROOT_PASS
Y
Y
Y
Y
END

	sleep 1
	mysql -u root -e "CREATE DATABASE $MARIADB_DATABASE_NAME;"
	mysql -u root -e "CREATE USER '$MARIADB_DATABASE_ADMIN'@'%' IDENTIFIED BY '$MARIADB_DATABASE_ADMIN_PASS';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$MARIADB_DATABASE_ADMIN'@'%';"
	mysql -u root -e "FLUSH PRIVILEGES;"

	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_DATABASE_ROOT_PASS';"
	mysql -u root -p$MARIADB_DATABASE_ROOT_PASS -e "FLUSH PRIVILEGES;"
	mysqladmin -u root -p$MARIADB_DATABASE_ROOT_PASS shutdown

else
	sleep 1
	echo "Database is already configured"
fi

echo "Database is ready to use."

exec "$@"
