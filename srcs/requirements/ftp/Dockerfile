FROM alpine:3.21.5

RUN apk update && apk add --no-cache vsftpd

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY tools/ftp.sh /usr/local/bin/ftp.sh
RUN chmod +x /usr/local/bin/ftp.sh

EXPOSE 21 21100-21110

ENTRYPOINT ["ftp.sh"]
CMD []
