#!/bin/sh

# setting imap user password
adduser -D -s /sbin/nologin -u 1000 -h /var/lib/mail $IMAP_USER
su $IMAP_USER -s /bin/sh -c 'mkdir -p $HOME/Maildir'

echo "$IMAP_USER:{PLAIN}$IMAP_PASSWORD:1000:1000::/var/lib/mail" > /etc/dovecot/users

# setting .fetchmailrc
if [ ! -e /var/lib/mail/.fetchmailrc ]; then
    sed -e "s/@FETCH_SERVER@/${FETCH_SERVER}/" /root/fetchmailrc.tmpl > /var/lib/mail/.fetchmailrc
    sed -i -e "s/@FETCH_PROTOCOL@/${FETCH_PROTOCOL}/" /var/lib/mail/.fetchmailrc
    sed -i -e "s/@FETCH_USER@/${FETCH_USER}/" /var/lib/mail/.fetchmailrc
    sed -i -e "s/@FETCH_PASSWORD@/${FETCH_PASSWORD}/" /var/lib/mail/.fetchmailrc
fi

chown $IMAP_USER.$IMAP_USER /var/lib/mail/.fetchmailrc
chmod 700 /var/lib/mail/.fetchmailrc

# run fetchmail as daemon
if [ "$FETCH_ENABLED" = "true" ]; then
    su $IMAP_USER -s /bin/sh -c "fetchmail -d $FETCH_INTERVAL"
fi

# run dovecot as forground
dovecot -F

