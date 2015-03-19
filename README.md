docker-consul-template-haproxy
==============================

forked from https://github.com/AnalogJ/docker-consul-template-haproxy.
DockerHub Repository: https://registry.hub.docker.com/u/shayashibara/docker-consul-template-haproxy/

## Overview

This repository contains a scripts for creating image with haproxy and consul-template.

## Requirements

- Docker (Tested on 1.4.1)
- Consul (Tested on 0.5.0)

## Usage

- Simple

```
docker pull shayashibara/docker-consul-template-haproxy
docker run -d shayashibara/docker-consul-template-haproxy
```

- Link to consul (in docker)

```
docker run -p 8400:8400 -p 8500:8500 -p 8600:53/udp --name consul progrium/consul -server -bootstrap
docker run -d --link consul:consul shayashibara/docker-consul-template-haproxy
```

- Link to consul (in outside)

```
docker run -d -e "CONSUL_PORT_8500_TCP_ADDR=10.0.0.1" -e "CONSUL_PORT_8500_TCP_PORT=8500" shayashibara/docker-consul-template-haproxy
```

## vars

You can customize container by passing environment variables.

|variable|value|
|:--|:--|
|CONSUL_PORT_8500_TCP_ADDR| default: `172.17.42.1` |
|CONSUL_PORT_8500_TCP_PORT| default: `8500` |
