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
Get the docker image, or cook your own.

```bash 
docker pull jeroenflvr/bizmonx:0.0.2
```

## Environment Variables
| var | default value | description |
| --- | ------------- | ----------- |
| XYMON_HOST | localhost | hostname for xymon web server |
| XYMON_PORT | 1984 | port xymond listens on |
| XYMON_WEB_SERVER_PORT | 8080 | port for the apache web server |
| XYMON_GATEWAY_SERVER_PORT | 1976 | port for the gateway server |
