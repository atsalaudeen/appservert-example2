#!/bin/bash

# Generate private key
openssl genrsa 2048 > ca-test-private-key.pem

# Generate Certificate with key above

openssl req -new -x509 -nodes -sha1 -days 3650 -extensions v3_ca -key ca-test-private-key.pem -out ca-test-public.crt -subj "/C=UK/ST=Greater London/L=London/O=MyTestName Ltd/CN=myCompanyTestWeb-site1.com"

# Check CN in the certificate
openssl x509 -text -in ca-test-public.crt|grep CN

