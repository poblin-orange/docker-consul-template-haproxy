#!/bin/bash

HAPROXY="/etc/haproxy"
PIDFILE="/var/run/haproxy.pid"
CONFIG_FILE=${HAPROXY}/haproxy.cfg
TEMPLATE=${HAPROXY}/haproxy.template
$BACKEND_SERVICE=${$BACKEND_SERVICE:webapp}

cd "$HAPROXY"

sed -i -e "s/webapp/${$BACKEND_SERVICE}/g" $TEMPLATE

haproxy -f "$CONFIG_FILE" -p "$PIDFILE" -D -st $(cat $PIDFILE)


env

/usr/local/bin/consul-template -consul ${CONSUL_PORT_8500_TCP_ADDR:-172.17.42.1}:${CONSUL_PORT_8500_TCP_PORT:-8500} \
    -template "/etc/haproxy/haproxy.template:/etc/haproxy/haproxy.cfg:/hap.sh" \
    -log-level debug
