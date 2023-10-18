## Traefik trials using Docker Compose

### Whoami

Start:  sudo docker-compose -f whoami_traefik.yml up (single whoami instance)

Access via browser: http://whoami.docker.localhost/

Traefik dashboard:  http://localhost:8080


### Whoami, HTTPS, password authetication
TBD

<br><br>

### Nextcloud, internet usage via duckdns.org

*under constructions!!*

Uses duckdns.org to provide Nextcloud "internet handle", see .env file

Defines also local name for Nextcloud in case duckdns is down, see .yml file (nextcloud labels)
<br>
<br>

Duckdns defines "host name" ,like abc.duckdns.org and passes it to your public IP (they prodive IP update scripts)
<br>
Router needs to bypass ports 80 and 443 to your server (using fixed IP) hosting Nextcloud 
<br>
Traefik passess data to Nextcloud
<br>

Works ok with web browsers (ubuntu/mint)
<br>
<br>

make --> build containers, create networks, start system

make clean -->  clean build contents


.env file for defines



