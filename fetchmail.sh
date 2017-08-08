#/bin/sh

while :
do
  su $IMAP_USRE -s /bin/sh -c fetchmail
  sleep $FETCH_INTERVAL
done
