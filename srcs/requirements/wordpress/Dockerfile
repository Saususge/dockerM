FROM alpine:3.21.5

RUN apk add --no-cache php83-cli php83-phar php83-fpm php83-curl php83-xml php83-exif php83-fileinfo php83-mbstring php83-mysqli php83-openssl php83-zlib php83-opcache php83-gd curl mariadb-client php83-redis redis php83-tokenizer php83-ctype

RUN sed -i 's/memory_limit = 128M/memory_limit = -1/' /etc/php83/php.ini

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

EXPOSE 8000

COPY tools/wp.sh /usr/local/bin/wp.sh
RUN chmod +x /usr/local/bin/wp.sh

ENTRYPOINT ["wp.sh"]
CMD ["php-fpm83", "-F"]
