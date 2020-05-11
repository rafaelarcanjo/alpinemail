FROM alpine:3

LABEL Rafael Arcanjo

RUN	apk add --no-cache postfix postfix-sqlite dovecot dovecot-pop3d dovecot-sqlite syslog-ng \
		opendkim postgrey perl-io-socket-inet6 sqlite && \
	mkdir -p /etc/postfix/db /etc/opendkim/keys

ADD sqlite.sql /root/

COPY dovecot /etc/dovecot
COPY ssl/*.pem /etc/ssl/

ADD postfix/mailname /etc/mailname
ADD postfix/postgrey /etc/default/

ADD  resolv.conf	/var/spool/postfix/etc/
COPY postfix/db/*	/etc/postfix/db/
COPY postfix/*.cf	/etc/postfix/

COPY opendkim/keys/* /etc/opendkim/keys/
COPY opendkim/*.conf /etc/opendkim/

ADD up.sh /usr/bin/ 

EXPOSE 25 465 993 995

RUN mkdir -p /var/db/sqlite/ /var/vmail && cat /root/sqlite.sql | sqlite3 /var/db/sqlite/mail.sqlite && \
	rm -f /root/sqlite.sql && chmod 770 /var/vmail/ && chown vmail:mail /var/vmail/ && \
	rm -f /etc/postfix/dynamicmaps.cf.d/sqlite && chmod 640 -R /etc/postfix/* && \
	postalias /etc/postfix/db/alias && postmap /etc/postfix/db/recipient && \
	cp -f /etc/services /var/spool/postfix/etc && \
	chown opendkim:opendkim /etc/opendkim/keys/* && chmod 400 /etc/opendkim/keys/* && \
	mkdir -p /var/run/opendkim && chown opendkim:opendkim -R /var/run/opendkim && \
	chmod u+x /usr/bin/up.sh

CMD up.sh