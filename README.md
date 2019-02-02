# Dockerized Web Development Services

These services provide a foundation for my way of building websites within docker containers.

## Prerequisites

Linux / Unix host, and Docker must be installed and configured on the system

## Installation

Replace \${DOCKERDEV_LOCATION} with the path to the downloaded repository

```bash
git clone https://github.com/nevinsm/dockerized-webdev-services.git
cd ${DOCKERDEV_LOCATION}
chmod +x networks.sh
./networks.sh
docker-compose up -d
```

## Setting up as a service using systemd

Replace \${DOCKERDEV_LOCATION} with the absolute path to the downloaded repository, in both the commands and `dockerdev.service`

```bash
sudo ln -s ${DOCKERDEV_LOCATION}/dockerdev.service /etc/systemd/system/dockerdev.service
sudo systemctl enable dockerdev.service
sudo systemctl start dockerdev.service
```

## Adding CA to trust store

### Arch Linux

```bash
sudo cp ${DOCKERDEV_LOCATION}/server-certs/chain.crt /etc/ca-certificates/trust-source/anchors/dockerdev.crt
sudo trust extract-compat
```

## Usage

See my (Compose Templates)[https://github.com/nevinsm/dockerized-webdev-templates.git] repository for compatible compose files, and (jwilder/nginx-proxy)[https://github.com/jwilder/nginx-proxy] for environment variables related to the proxy. You can also attach a service to mailhog for smtp testing via the `mail` network, and phpmyadmin via the `phpmyadmin` network.

The key components are:

```yaml
someservice:
  environment:
    VIRTUAL_HOST: mailhog.dev.localhost
    CERT_NAME: server
  networks:
    - proxy

networks:
  proxy:
    external:
      name: proxy
```

## Included services

- (Nginx proxy)[https://github.com/jwilder/nginx-proxy]
- (Certificate Authority)[https://github.com/cloudflare/cfssl]
- (phpMyAdmin)[https://www.phpmyadmin.net]
- (Swagger Editor)[https://github.com/swagger-api/swagger-editor]
- (Mailhog)[https://github.com/mailhog/MailHog]

## Tested On

- Arch Linux

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

MIT

Please note that running the commands in this README will start and build Docker containers, and images, and as with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).
