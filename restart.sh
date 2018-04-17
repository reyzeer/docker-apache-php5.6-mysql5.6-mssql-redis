#/bin/bash

# Load .env file
set -a
. ./.env
set +a

docker-compose down
docker-compose up
