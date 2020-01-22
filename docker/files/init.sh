#!/bin/bash
set -ex
INTERFACE=${1:br0}
sed -i 's/^interface=.*/interface=af_packet::'"${INTERFACE}"'/g'  /opt/zeek/etc/node.cfg
/opt/zeek/bin/zeekctl install
/opt/zeek/bin/zeekctl start

# Simple watchdog
while true;
do
  pgrep -x zeek
  sleep 5
done
