#!/bin/sh

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "MariaDB: Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mariadbd --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat $MARIADB_ROOT_PASSWORD_FILE)';
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$(cat $MYSQL_USER_FILE)'@'%' IDENTIFIED BY '$(cat $MYSQL_PASSWORD_FILE)';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$(cat $MYSQL_USER_FILE)'@'%';
FLUSH PRIVILEGES;
EOF
fi
exec "$@"
