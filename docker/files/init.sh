#!/bin/bash
set -ex
INTERFACE=${1:br0}
sed -i 's/^interface=.*/interface=af_packet::'"${INTERFACE}"'/g'  /opt/zeek/etc/node.cfg

cp /opt/zeek/share/zeek/site/local.zeek.template /opt/zeek/share/zeek/site/local.zeek

# Append to local.zeek
if [ -f /opt/zeek/share/zeek/site/local.zeek.append ]; then
    echo "@load local.zeek.append" >> /opt/zeek/share/zeek/site/local.zeek
fi

/opt/zeek/bin/zeekctl install
/opt/zeek/bin/zeekctl start

# Simple watchdog
while true;
do
  sleep 300
  /opt/zeek/bin/zeekctl cron
done
