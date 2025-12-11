FROM alpine:3.21.5

RUN apk update && apk add --no-cache nginx

COPY conf/default.conf /etc/nginx/http.d/default.conf

COPY content/ /var/www/html

RUN sed -i 's/user nginx;/user nobody;/' /etc/nginx/nginx.conf

RUN chown -R nobody:nobody /var/www/html
RUN chmod -R 755 /var/www/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
