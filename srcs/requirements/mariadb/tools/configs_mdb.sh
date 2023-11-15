#!/bin/bash

if [ ! -d "/var/lib/mysql/$MARIADB_DATABASE_NAME" ]; then

    /etc/init.d/mariadb start

    sleep 2

    mysql -u root -e "CREATE DATABASE $MARIADB_DATABASE_NAME;"
    mysql -u root -e "CREATE USER '$MARIADB_DATABASE_ADMIN'@'%' IDENTIFIED BY '$MARIADB_DATABASE_ADMIN_PASS';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$MARIADB_DATABASE_ADMIN'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"

    /etc/init.d/mariadb stop

else
    /etc/init.d/mariadb start
    sleep 2
    /etc/init.d/mariadb stop
    echo "Database is already configured"
fi

echo "Database is ready to use."

exec "$@"
