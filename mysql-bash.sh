#/bin/bash

# Load .env file
set -a
. ./.env
set +a

docker exec -it ${DOCKER_PREFIX}-mysql /bin/bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec bash"
