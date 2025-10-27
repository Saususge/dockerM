FROM alpine:3.21.5

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY conf/db.conf /etc/mysql/my.cnf

COPY tools/db.sh /usr/local/bin/db.sh
RUN chmod +x /usr/local/bin/db.sh

EXPOSE 3306

ENTRYPOINT ["db.sh"]
CMD ["mariadbd"]
