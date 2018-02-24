#!/bin/bash

# Start mssql by docker-compose - losing data. Why? Becouse is microsoft...
#       https://adilsoncarvalho.com/using-mssql-on-linux-using-docker-for-mac-a5d4ac81e57f

docker create -v /var/opt/mssql --name server-mssql \
  microsoft/mssql-server-linux \
  /bin/true
