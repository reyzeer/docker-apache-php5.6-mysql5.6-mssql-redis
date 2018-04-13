#/bin/bash

PASS=root

sudo -u $USER echo -e "$PASS\n$PASS" | sudo docker exec -i in360-php passwd

sudo docker exec -it in360-php service ssh start

sudo -u $USER sshpass -p "$PASS" ssh -R 9000:localhost:9000 root@172.20.128.2

