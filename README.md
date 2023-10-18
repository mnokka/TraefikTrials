# Traefik trials using Docker Compose

### Whoami
Start: sudo docker-compose -f whoami_traefik.yml up (single whoami instance)

Access via browser: http://whoami.docker.localhost/

Traefik dashboard: http://localhost:8080

### Whoami, HTTPS, password authetication
Start: sudo docker-compose -f whoami_http_password.yml up

Generated basic password using MD5

htpasswd -bn admin cat (used in this example)

if any $ in generated password hash, use $$ for correct escaping

useraccount and passoword in .env file approach in use

.env ---> AUTH=admin:$apr1$LqFnjZq8$rQqfi6TsedzIyMTIlpuJU/


### Whoami, HTTPS via Let's Encrypt
Starting: sudo docker-compose -f whoami_https.yml up

Does HTTPS connection OK with Lets Encrypt


# Nextcloud, internet usage via duckdns.org DDNS

Uses duckdns.org to provide Nextcloud "internet handle", see .env file

Defines also local name for Nextcloud in case duckdns is down, see .yml file (nextcloud labels section)


Duckdns defines "host name" ,like abc.duckdns.org and passes it to your public IP (they prodive IP update scripts)

Router needs to bypass ports 80 and 443 to your server (using fixed IP) hosting Nextcloud

Traefik passess data to Nextcloud

Works ok with web browsers (ubuntu/mint)

### Executing

make --> build containers, create networks, start system

make clean --> clean build contents

or start system after first make run --> docker-compose -f nextcloud3.yml up

.env file for defines (volumes, DDNS name, Let's Encrypt acme file)

Note: Collabora (NextCloud office) has been coomented out from yml-file as it did not open office files
