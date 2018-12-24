#!/usr/bin/env bash

service sshd start

IP=$(ip addr show eth0 | grep -w inet | awk '{ print $2}' | cut -d "/" -f1)
HOSTNAME_SUFFIX=`echo -e "${IP}" | cut -d '.' -f 4`
hostname drill-${HOSTNAME_SUFFIX}

sed -i 's/localhost/zk-service/g' /opt/drill/conf/drill-override.conf
/opt/drill/bin/drillbit.sh restart

while true; do sleep 5; done
