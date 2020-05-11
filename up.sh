#!/bin/sh
syslog-ng && \
	opendkim -x /etc/opendkim/opendkim.conf && \
	dovecot -c /etc/dovecot/dovecot.conf && \
	postgrey --daemonize --inet=127.0.0.1:10023 && \
	postfix -c /etc/postfix/ start ;
tail -f /var/log/mail.log
