# Includes assistance from OpenAI's GPT-3.5 model ( https://openai.com/ )

source .env
source .db_pwds

DATE=$(date +"%d_%m_%Y")

LOGFILE=$BACKUPTARGET/mariadb_backup_$DATE.sql.log


docker_container_exists() {
    local name="$1"
    if sudo docker ps -a --format '{{.Names}}' | grep -q "^$name$"; then
        return 0  # Container exists
    else
        return 1  # Container does not exist
    fi
}

echolog() {
    echo "$@" 
    echo "$@" >> $LOGFILE
}


read -p "Enter a Mariadb Docker container name: " container_name

if docker_container_exists "$container_name"; then
    echolog "OK: Docker container '$container_name' exists."
else
    echolog "ERROR: Docker container '$container_name' does not exist."
    exit 1
fi

if sudo docker exec -it $container_name mysqldump --version 2>&1 | grep -q 'mysqldump'; then
    echolog "OK: mysqldump is installed in the container."
else
    echolog "ERROR: mysqldump is not installed in the container."
    echolog "Installation info:"
    echolog "docker exec -it $container_name /bin/bash"
    echolog "apt-get update"
    echolog "apt-get install mysql-client"
    exit 1
fi

sudo docker exec -i $container_name mysqldump -u $MYSQL_USER --password=$MYSQL_ROOT_PASSWORD --all-databases > $BACKUPTARGET/mariadb_backup_$DATE.sql 2>> $LOGFILE
