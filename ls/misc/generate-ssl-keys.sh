#!/bin/sh
# Root CA
openssl genrsa -out root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key root-ca-key.pem -subj "/C=RU/ST=MOS/L=MOS/O=SBT/OU=IT/CN=ROOT" -out ca.crt -days 730