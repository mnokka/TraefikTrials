## Traefik trials using Docker Compose

### Whoami

Start:  sudo docker-compose -f whoami_traefik.yml up (single whoami instance)

Access via browser: http://whoami.docker.localhost/

Traefik dashboard:  http://localhost:8080


### Whoami, HTTPS, password authetication


Starting:  sudo docker-compose -f whoami_https_password.yml up

Access via browser: https://sala.docker.localhost, will ask password (admin/cat)

.env file defines account and passord (md5 hashed)


# Nextcloud, redis, db, traefik (proxy)
### in nextcloud directory:

under constructions!!

make --> build containers, create networks, start system

make clean -->  clean build contents


Docker used volumes defined in .env:

Database auth info defined: .db_pwds 



