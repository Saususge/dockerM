#!/bin/sh

WP_PATH="/var/www/html"

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    while ! mariadb -h"$MYSQL_HOSTNAME" -u"$(cat $MYSQL_USER_FILE)" -p"$(cat $MYSQL_PASSWORD_FILE)" -e "status" > /dev/null 2>&1; do
        sleep 1
    done
    wp core download --path="$WP_PATH" --allow-root

    wp config create --path="$WP_PATH" \
                     --dbname="$MYSQL_DATABASE" \
                     --dbuser="$(cat $MYSQL_USER_FILE)" \
                     --dbpass="$(cat $MYSQL_PASSWORD_FILE)" \
                     --dbhost="$MYSQL_HOSTNAME" \
                     --allow-root

    wp core install --path="$WP_PATH" \
                    --url="$DOMAIN_NAME" \
                    --title="Inception" \
                    --admin_user="$(cat $WP_ADMIN_USER_FILE)" \
                    --admin_password="$(cat $WP_ADMIN_PASS_FILE)" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --allow-root

    wp user create --path="$WP_PATH" \
                   "$WP_SECOND_USER" \
                   "$WP_SECOND_EMAIL" \
                   --role=author \
                   --user_pass="$(cat $WP_SECOND_PASS_FILE)" \
                   --allow-root
fi
exec "$@"
