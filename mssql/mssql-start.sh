#!/bin/bash

# Start mssql by docker-compose - losing data. Why? Becouse is microsoft...
#       https://adilsoncarvalho.com/using-mssql-on-linux-using-docker-for-mac-a5d4ac81e57f

docker create -v /var/opt/mssql --name server-mssql \
  microsoft/mssql-server-linux \
  /bin/true

docker run \
  -e 'ACCEPT_EULA=Y' \
  -e 'SA_PASSWORD=password' \
  -p 1433:1433 \
  --volumes-from server-mssql \
  --name 'server-mssql-server' \
  -d \
  microsoft/mssql-server-linux
  # --ip 172.20.128.5
  #--net server-static-network
