#!/bin/bash

#
# CORS için proxy-pass-url önemlidir.
#

docker rm registry-ui --force

docker run --rm -d --name registry-ui -h registry-ui -p 80:80 \
  -e REGISTRY_TITLE="Registry @ localhost" \
  -e REGISTRY_URL="http://registry" \
  -e NGINX_PROXY_PASS_URL="https://registry" \
  -e DELETE_IMAGES=true \
  -e SHOW_CONTENT_DIGEST=true \
  -e SINGLE_REGISTRY=true \
  joxit/docker-registry-ui:latest
