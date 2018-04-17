#/bin/bash

# Load .env file
set -a
. ./.env
set +a

PASS=root
sudo -u $USER echo -e "$PASS\n$PASS" | sudo docker exec -i ${DOCKER_PREFIX}-http passwd
sudo docker exec -it ${DOCKER_PREFIX}-http service ssh start


