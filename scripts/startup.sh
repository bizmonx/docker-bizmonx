#!/bin/bash

# Add ServerName at the top of apache2.conf
# sed -i '1s/^/ServerName localhost\n/' /etc/apache2/apache2.conf
port=${XYMON_WEB_SERVER_PORT:-8080}
sed -i "s/Listen 80.*$/Listen $port\n" /etc/apache2/ports.conf

# Start Apache in the background
service apache2 start

# Start xymon
sed -i "s/^XYMONSERVERHOSTNAME.*$/XYMONSERVERHOSTNAME=\"$(hostname)\"/"  /home/xymon/server/etc/xymonserver.cfg
lhost="127.0.0.1    $(hostname) # bdd http://$(hostname):${XYMON_PORT}"
sed -i "s/^127\.0\.0\.1.*/$(echo "$lhost" | sed 's/[&/\]/\\&/g')/" /home/xymon/server/etc/hosts.cfg

/home/xymon/server/bin/xymon.sh start

# Start http gateway
/home/xymon/bizmonx-gateway/bin/linux-amd64/bizmonx-gateway

# Keep the container running by waiting on Apache process
# This will keep the container alive and not exit
while true; do
    apache2ctl status > /dev/null
    if [ $? != 0 ]; then
        echo "Apache has exited."
        exit 1
    fi
    sleep 60
done
