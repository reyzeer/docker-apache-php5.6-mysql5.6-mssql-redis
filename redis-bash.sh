#/bin/bash

# Load .env file
set -a
. ./.env
set +a

docker exec -it ${DOCKER_PREFIX}-redis /bin/bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec bash"
