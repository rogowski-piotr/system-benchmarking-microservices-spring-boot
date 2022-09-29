#!/bin/sh

# Decrypt the file
cd /infrastructure/ssh_key
gpg --quiet --decrypt --batch --yes --passphrase="test" admin.pem.gpg > admin.pem
cd
mv ./infrastructure/ssh_key/admin.pem ./../../.ssh/admin.pem

