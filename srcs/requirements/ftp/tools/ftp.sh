#!/bin/sh

adduser -D -h /var/www/html -G nobody $FTP_USER

echo "$FTP_USER:$(cat $FTP_PASS_FILE)" | chpasswd

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
