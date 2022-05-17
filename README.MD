# config.yml
Bu dosya yada env ile degişiklik yapılabilir.

``` htpasswd -b -B -c auth/htpasswd  dockeruser dockerpass```



# /etc/docker/daemon.json

sistem bazlı bir ayardı. 

```
"registry-mirrors": ["http://registry:5000"],
"insecure-registries": ["registry:5000"],
```

kullanici bazli 

```
ls -alh ~.docker/config.json
cat ~.docker/config.json
```



# SSL üretim

```
openssl genrsa -out certs/registry.key 4096
openssl req -new -x509 -text -days 3650 -subj "/C=TR/ST=TR/CN=registry" -key certs/registry.key -out certs/registry.crt
openssl req -x509 -days 3650 --nodes -subj "/C=TR/ST=TR/CN=registry" -out certs/registry.crt -keyout certs/registry.key

sudo cp certs/registry.crt  /etc/ssl/registry.crt
sudo update-ca-certificates
curl -> /etc/ssl/certs/ca-certificates.crt doyasini kullanir...

sudo cp certs/registry.crt  /usr/share/ca-certificates/
sudo update-ca-certificates


# hosts file 
``` 
add /etc/hosts    "127.0.0.1 registry"

```

# test

```
curl -vvv -u "dockeruser:dockerpass" -isk https://registry/v2/_catalog
```





