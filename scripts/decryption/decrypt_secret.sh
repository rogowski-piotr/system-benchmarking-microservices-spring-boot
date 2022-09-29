#!/bin/sh

# Decrypt the file
mkdir $HOME/secrets
# --batch to prevent interactive command
# --yes to assume "yes" for questions
gpg --quiet --batch --yes --decrypt --passphrase="$PASSWORD" \
--output $HOME/secrets/admin.pem ./infrastructure/ssh_key/admin.pem.gpg