#!/bin/bash

# Generate Certificate
curl -d '{ "request": {"hosts":["*.dev.localhost"], "names":[{"C":"US", "ST":"Ohio", "L":"Cleveland", "O":"Morgan Software Foundry", "OU":"IT"}], "CN": "dev.localhost"} }' http://ca:8888/api/v1/cfssl/newcert -o /certs/tmpcert.json

cd /certs
cfssljson -f tmpcert.json

mv cert.csr server.csr
mv cert.pem server.crt
mv cert-key.pem server.key

# Remove JSON Data
rm -Rf /certs/tmpcert.json

# Get root public cert
curl -d '{"label": "primary"}' http://ca:8888/api/v1/cfssl/info -o /certs/tmpcert.json

cfssljson -f tmpcert.json

mv cert.pem chain.crt

# Remove JSON Data
rm -Rf /certs/tmpcert.json
