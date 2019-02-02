FROM golang:1.11.5

ENV USER root

# install cfssl
RUN go get -u github.com/cloudflare/cfssl/cmd/cfssljson
ADD generate-certs.sh /

ENTRYPOINT [ "/generate-certs.sh" ]
