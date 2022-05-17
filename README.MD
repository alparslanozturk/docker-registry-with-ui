


```
ls -alh ~.docker/config.json
cat ~.docker/config.json



```


docker run -d \
  --restart=always \
  --name registry \
  -v "$(pwd)"/data:/var/lib/registry \
  -v "$(pwd)"/certs:/certs \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  -p 443:443 \
  registry:2


docker run -d \
  --restart=always \
  --name registry \
  -v "$(pwd)"/config.yml:/etc/docker/registry/config.yml \
  -v "$(pwd)"/data:/var/lib/registry \
  -v "$(pwd)"/certs:/certs \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  -p 443:443 \
  registry:2



log:
  accesslog:
    disabled: true
  level: debug
loglevel: debug
storage:
  delete:
    enabled: true
...
proxy:
  remoteurl: https://registry-1.docker.io
  username: [username]
  password: [password]




version: 0.1
log:
  fields:
    service: registry
storage:
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
