# dev-localhost
Ambiente dockerizado localhost completo com webserver(nginx|apache) php e MySQL 

### MySQL
```sh
docker run --detach \
--name mysql \
--hostname mysql-localhost  \
--restart always \
-e MYSQL_ROOT_PASSWORD=63drmDruGvjJ7HWD \
--volume /var/lib/mysql:/var/lib/mysql \
--network="host" \
-p 3306:3306 \
mysql:latest
```
Utilizo o fedora 25 por isso instalei os utilitarios do mysql no host:
```sh
sudo dnf install -y mysql-community-client.x86_64
```
