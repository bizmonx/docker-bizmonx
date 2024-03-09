# BizMonX

**W I P**

A xymon fork for mainly non-systems monitoring.

## Introduction

Just the start, but here are the goals:

-> gradually rewrite using ziglang

1. move build to zig
2. rewrite frontend! 
3. rewrite clients
4. rewrite endpoints (HTTP/2 gRPC vs REST)
5. rewrite database (duckdb, tigerbeetle, ...?)
6. rewrite charts
7. manage hosts.cfg or replace
...
n. rewrite while maybe reusing bits?


+ already added temporary http(s) gateway (golang), to be replaced with zig (zap)


## Why Zig, not Go/Rust?
mainly because of the same reason Modular Mojo will push java out of data, it allows a gradual 
move while learning the language


## Get Started
- get the docker image, or cook your own
```bash 
docker pull jeroenflvr/bizmonx:0.0.1
```
- set ServerName
- start apache
```bash
services apache2 start
```
- start xymon
```bash
/home/xymon/server/bin/xymon.sh start
```

Environment Variables
XYMON_HOST
XYMON_PORT
XYMON_WEB_SERVER_PORT
XYMON_GATEWAY_SERVER_PORT
