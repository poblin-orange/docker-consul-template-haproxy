#!/bin/bash

HAPROXY="/etc/haproxy"
PIDFILE="/var/run/haproxy.pid"
CONFIG_FILE=${HAPROXY}/haproxy.cfg
TEMPLATE=${HAPROXY}/haproxy.template
SERVICE_TAG=${SERVICE_TAG:webapp}

cd "$HAPROXY"

sed -i -e "s/webapp/${SERVICE_TAG}/g" $TEMPLATE

haproxy -f "$CONFIG_FILE" -p "$PIDFILE" -D -st $(cat $PIDFILE)

current=$(curl -X GET ${CONSUL_PORT_8500_TCP_ADDR:-172.17.42.1}:${CONSUL_PORT_8500_TCP_PORT:-8500}/v1/kv/backend/current)
[[ -z "$current" ]] && sed -i -e "s/default_backend.*$/default_backend default/" $TEMPLATE

env

/usr/local/bin/consul-template -consul ${CONSUL_PORT_8500_TCP_ADDR:-172.17.42.1}:${CONSUL_PORT_8500_TCP_PORT:-8500} \
	  -template "/etc/haproxy/haproxy.template:/etc/haproxy/haproxy.cfg:/hap.sh"
