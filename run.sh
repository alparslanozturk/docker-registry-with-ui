#!/bin/bash


### test: curl -vvv -u "dockeruser:dockerpass" -isk https://registry/v2/_catalog


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

