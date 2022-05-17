#!/bin/bash


# registry/config.yml dosyasi buradaki env ile degistirilir. 
# htpasswd -b -B -c auth/htpasswd  dockeruser dockerpass
#
# /etc/docker/daemon.json
#  "registry-mirrors": ["http://registry:5000"],
#  "insecure-registries": ["registry:5000"],
#

#openssl genrsa -out certs/registry.key 4096
#openssl req -new -x509 -text -days 3650 -subj "/C=TR/ST=TR/CN=registry" -key certs/registry.key -out certs/registry.crt

# openssl req -x509 -days 3650 --nodes -subj "/C=TR/ST=TR/CN=registry" -out certs/registry.crt -keyout certs/registry.key
#
# sudo cp certs/registry.crt  /etc/ssl/registry.crt
# sudo update-ca-certificates
# curl -> /etc/ssl/certs/ca-certificates.crt doyasini kullanir...
#
# sudo cp certs/registry.crt  /usr/share/ca-certificates/   
# sudo update-ca-certificates
#
#
# add /etc/hosts    "127.0.0.1 registry"
#
#
# test: curl -vvv -u "dockeruser:dockerpass" -isk https://registry/v2/_catalog


docker rm registry --force 

docker run --rm -d --name registry -h registry -p 443:443 -p 5000:5000 \
  -v $(pwd)/config.yml:/etc/docker/registry/config.yml \
  -v $(pwd)/data:/var/lib/registry \
  -v $(pwd)/auth:/auth \
  -v $(pwd)/certs:/certs \
  -e REGISTRY_AUTH_HTPASSWD_REALM="basic-realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH="/auth/htpasswd" \
  -e REGISTRY_STORAGE_DELETE_ENABLED=true \
  -e REGISTRY_HTTP_TLS_KEY="/certs/registry.key" \
  -e REGISTRY_HTTP_TLS_CERTIFICATE="/certs/registry.crt" \
  -e REGISTRY_STORAGE_DELETE_ENABLED=true \
  -e REGISTRY_HTTP_ADDR="0.0.0.0:443" \
  registry:2

