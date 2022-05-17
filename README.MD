iki adet docker vardır. bunlar run.sh ve run-ui.sh ile çalıştırılabilir. Docker registry 443 portunu ui ile 80 portunu kullancak şekilde ayarlarladım. 



# config.yml
Bu dosya yada docker run edilirken env(-e) ile degişiklik yapılabilir.



# htpasswd
Bu dosya ile auth işlemi için kullanılır. -B parametresi gereklidir. -b komut satırından çalışması için, -c dosya create etmesi içindir. 
``` htpasswd -b -B -c auth/htpasswd  dockeruser dockerpass```



# /etc/docker/daemon.json
Bu dosya sistem bazlı ayarlar vardır. Aşağıdaki girdiler örnektir. Eğer 443 degilde 5000 portundan registry çalıştırılacaksa eklenemesi gerekir.
burada mirrors konusunu inceleyebilirsiniz. 

```
"registry-mirrors": ["https://registry"],
```
# login 
```
$ docker login registry
Username: dockeruser
Password:
WARNING! Your password will be stored unencrypted in /home/kullan/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

```

Eğer kurulum 443 portundan ile sadece mirrors özelligini ekleseniz yeterli olur.  örn:  ``https://registry.ornek.com``
```
"registry-mirrors": ["https://registry"],
```

kullanici bazli ayalar sanırım bu dosyalarda.
```
ls -alh ~.docker/config.json
cat ~.docker/config.json
```



# SSL üretim
nodes -> private key des ile şifrelememesi içindir. 

days 10 yıldır. 

subj kolaylik olsun ekledim. 

OS sürümüne göre bunu  curl ile kullanabilmek icin CA ve trusted e eklemek gerekir. :-)


```
openssl genrsa -out certs/registry.key 4096
openssl req -new -x509 -text -days 3650 -subj "/C=TR/ST=TR/CN=registry" -key certs/registry.key -out certs/registry.crt
openssl req -x509 -days 3650 --nodes -subj "/C=TR/ST=TR/CN=registry" -out certs/registry.crt -keyout certs/registry.key

sudo cp certs/registry.crt  /etc/ssl/registry.crt
sudo update-ca-certificates
curl -> /etc/ssl/certs/ca-certificates.crt doyasini kullanir...

sudo cp certs/registry.crt  /usr/share/ca-certificates/
sudo update-ca-certificates
```


# hosts file 
``` 
add /etc/hosts    "127.0.0.1 registry"
```

# test
```
curl -vvv -u "dockeruser:dockerpass" -isk https://registry/v2/_catalog
```





