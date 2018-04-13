#/bin/bash

docker exec -it in360-php /bin/bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec bash"
