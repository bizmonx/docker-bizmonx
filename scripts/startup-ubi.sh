#!/bin/bash

# Add ServerName at the top of apache2.conf
hname=${XYMON_HTTP_HOST_NAME:-$(hostname)}
sed -i "1s/^/ServerName $hname\n/" /etc/httpd/conf/httpd.conf 

port=${XYMON_WEB_SERVER_PORT:-8080}
sed "s/Listen 80.*$/Listen $port\n/" /etc/httpd/conf/httpd.conf > /tmp/config-file
cat /tmp/config-file > /etc/httpd/conf/httpd.conf

# Start Apache in the background
httpd &

# Start xymon
xymonbadge=${XYMON_BADGE:-Xymon}
sed -i "s/^XYMONLOGO.*$/XYMONLOGO=\"$xymonbadge\"/" /home/xymon/server/etc/xymonserver.cfg

sed -i "s/^XYMONSERVERHOSTNAME.*$/XYMONSERVERHOSTNAME=\"$(hostname)\"/"  /home/xymon/server/etc/xymonserver.cfg
lhost="127.0.0.1    $(hostname) # bdd http://$(hostname):$port"
sed -i "s/^127\.0\.0\.1.*/$(echo $lhost | sed 's/[&/\]/\\&/g')/" /home/xymon/server/etc/hosts.cfg 

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
