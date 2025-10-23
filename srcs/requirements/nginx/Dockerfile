FROM alpine:3.21.5

RUN apk update && apk add --no-cache nginx openssl

EXPOSE 443

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=KR/ST=Gyeongsan/O=42/CN=${DOMAIN_NAME}"

COPY conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]