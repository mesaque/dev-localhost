# dev-localhost
Ambiente dockerizado localhost completo com webserver(nginx|apache) php e MySQL 

### Pastas Necessárias a serem criadas
```sh
mkdir -p /var/www
sudo mkdir -p /etc/nginx
sudo mkdir -p /var/log/nginx
sudo mkdir -p /var/log/letsencrypt
sudo mkdir -p /etc/letsencrypt
sudo mkdir -p /usr/local/share/clamav
sudo mkdir -p /var/run2
```

```sh
#se não existir o usuario www-data por favor crie:
adduser --system --no-create-home -u 33 -g 33 -c "Web Sites" -d /var/www/html  www-data

#se o nome do grupo não for www-data
groupmod --new-name www-data tape
```

### MySQL
```sh

sudo cp mysql.cnf /etc/mysql.cnf


docker run --detach \
--name mysql \
--hostname mysql-localhost  \
--restart always \
-e MYSQL_ROOT_PASSWORD=63drmDruGvjJ7HWD \
--volume /var/lib/mysql:/var/lib/mysql \
--volume /etc/mysql.cnf:/etc/mysql/conf.d/mysql-localhost.cnf:ro \
--network="host" \
-p 3306:3306 \
mysql:latest
```
Utilizo o fedora 25 por isso instalei os utilitarios do mysql no host:
```sh
sudo dnf install -y mysql-community-client.x86_64
```

### PHPs
```sh
docker build  -t dev-localhost:php7 -f dockerfiles/dockerfile-php7 .

sudo cp php.ini /etc/php.ini
sudo cp msmtprc /etc/msmtprc

docker run --detach \
--name php7 \
--network="host" \
--hostname php7-localhost \
--restart always \
--volume /etc/php.ini:/usr/local/etc/php/conf.d/php-custom.ini:ro \
--volume /etc/msmtprc:/etc/msmtprc:ro \
--volume /var/www:/var/www:rw,z \
--volume /tmp/limbo:/limbo:rw,z \
dev-localhost:php7
```


### Nginx webserver
```sh
docker build  -t dev-localhost:nginx-webserver -f dockerfiles/dockerfile-nginx-module-pagespeed .

sudo cp -rf nginx/* /etc/nginx/

docker run --detach \
--name nginx \
--network="host" \
--hostname webserver-localhost \
--restart always \
--volume /var/www:/var/www:rw,z \
--volume /etc/nginx:/etc/nginx:rw,z \
--volume /etc/nginx:/usr/local/openresty/nginx/conf:rw,z \
--volume /etc/letsencrypt:/etc/letsencrypt:rw,z \
--volume /var/log/nginx:/var/log/nginx:rw,z \
--volume /var/log/nginx:/usr/local/openresty/nginx/logs:rw,z \
--volume /var/log/letsencrypt:/var/log/letsencrypt:rw,z \
-p 80:80 \
-p 443:443 \
dev-localhost:nginx-webserver
```

```sh
docker run --detach \
--name memcache \
--network="host" \
--hostname memcached-localhost \
--restart always \
memcached:latest
```
