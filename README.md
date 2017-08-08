# docker-myimap

## About

The **docker-myimap** helps buiding own IMAP server which contains below features.

* IMAP(S) server
* Server-side filtering by Sieve
* Compressed mail messages for saving disk space


## How to use

Run IMAP server as follows.

```
docker run \
  --name=myimap \
  -e FETCH_SERVER=yourmail.com \
  -e FETCH_PROTOCOL=pop3 \
  -e FETCH_USER=yourname \
  -e FETCH_PASSWORD=yourpassword \
  -p 143:143 \
  -p 993:993 \
  -p 4190:4190 \
  -v $(pwd)/data:/var/lib/mail \
  wadahiro/myimap
```

Then, you can login with myimap:password to the IMAP server.


## Licence

Licensed under the [MIT](/LICENSE) license.

