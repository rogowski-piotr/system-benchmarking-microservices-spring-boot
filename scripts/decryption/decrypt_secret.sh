#!/bin/sh

# Decrypt the file
gpg --quiet --decrypt --passphrase=""$PASSWORD"" ./infrastructure/ssh_key/admin.pem.gpg > .ssh/admin.pem


