#!/bin/sh

# Decrypt the file
gpg --quiet --decrypt --passphrase="$PASSWORD" ./infrastructure/ssh_key/admin.pem.gpg > admin.pem
mv ./infrastructure/ssh_key/admin.pem ./../../.ssh/admin.pem

