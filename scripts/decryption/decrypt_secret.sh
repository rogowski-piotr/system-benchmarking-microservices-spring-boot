#!/bin/sh

# Decrypt the file
gpg --quiet --decrypt --batch --yes --passphrase="$PASSWORD" ./infrastructure/ssh_key/admin.pem.gpg > admin.pem

