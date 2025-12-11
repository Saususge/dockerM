FROM alpine:3.21.5

RUN apk update && apk add --no-cache php83-cli php83-fpm php83-session php83-mysqli curl

RUN mkdir -p /var/www && chown -R nobody:nobody /var/www

RUN curl -L "https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php" -o /var/www/adminer.php

RUN mkdir -p /run/php/sessions && \
    chown -R nobody:nobody /run/php/sessions

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

EXPOSE 8000

CMD ["php-fpm83", "-F"]
