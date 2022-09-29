#!/bin/sh

# Decrypt the file
cd /infrastructure/ssh_key
gpg --quiet --decrypt --batch --yes --passphrase="test" ./infrastructure/ssh_key/admin.pem.gpg > admin.pem
mv admin.pem .ssh/admin.pem

