# <img src="web/img/logo.png" height="80" width="80"> BizMonX

**W I P**

A xymon fork for mainly non-systems monitoring. C -> [Zig](https://ziglang.org)

## Introduction

This is a rebranded fork of [Xymon](https://xymon.sourceforge.io/). Goal is to move away from some of the things that have grown obsolete, whilst
keeping the parts that are still very much relevant today.


## First, a few things about Xymon
### the good

- lightweight
- extremely flexible and pluggable
- fast
- extensible
- status inheritance and propagation across the configuration tree
- written in C
- ...

### the not so good
- frontend style and design
- management of the hosts and groups
- authentication and authorization
- db backend and rrd charts
- ...

## To do, the plan

Just the start, but here are the goals:

-> gradually rewrite using ziglang

1. move build to zig
2. rewrite frontend! 
3. rewrite clients
4. rewrite endpoints (HTTP/2 gRPC vs REST)
5. rewrite database (duckdb, tigerbeetle, ...?)
6. rewrite charts
7. manage hosts.cfg or replace
8. ...
9. n. rewrite while maybe reusing bits?


+ already added temporary http(s) gateway (golang), to be replaced with zig (zap)

## Doing
- finishing [ziglings](https://ziglings.org/): a practical guide to learning Zig
- write endpoint for: 
    - download hosts.cfg
    - upload hosts.cfg
    - restart xymon
 This will serve to make this project usable while refactoring.

## Done
- dockerize xymon build
- http(s) gateway (status + data, others are pending) -> to be replaced with zig (zap)
- cleanup frontend with css, no code changes yet
- debian and ubi (redhat) versions
- rebranding with monkey patching (temporary step)
- polished icons (temporary)


## Why Zig, not Go/Rust?
Mainly because of the same reason Modular Mojo will push java out of data: it allows for a gradual 
move from the existing codebase to a more performant language. Here, it might not be absolute runtime performance,
but definitely developer performance ;-).


Would have gone with Rust for a complete re-write.

Love Go for its simplicity.  The channels are already there.  Makes sense and with htmx, would have been 
an excellent choice.  However, Zig allows me to migrate and rework parts and even just reuse really easily.

## Get Started
Get the docker image, or cook your own.

linux/amd64

debian 12
```bash 
docker pull jeroenflvr/bizmonx:deb12-0.1.3
```

ubi9
```bash 
docker pull jeroenflvr/bizmonx:ubi9-0.1.3
```

## Environment Variables
| var | default value | description |
| --- | ------------- | ----------- |
| XYMON_HOST | localhost | hostname for xymon web server |
| XYMON_PORT | 1984 | port xymond listens on |
| XYMON_WEB_SERVER_PORT | 8080 | port for the apache web server |
| XYMON_GATEWAY_SERVER_PORT | 1976 | port for the gateway server |
| XYMON_BADGE | Xymon | the name which appears under the navigation bar on the left |
| TZ | Europe/Brussels | timezone |