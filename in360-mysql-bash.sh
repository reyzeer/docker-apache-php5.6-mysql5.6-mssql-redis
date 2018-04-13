#/bin/bash

docker exec -it in360-mysql /bin/bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec bash"
