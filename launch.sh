!#/bin/bash

cd app

IP=$(ip addr  | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1 | awk -F'/' '{print $1}')
sed -i -e "s/CONTAINER_IP/$IP/g" config.js

date
./app -c config.js 