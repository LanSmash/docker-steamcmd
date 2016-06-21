# docker-bind

# lansmash/bind:latest

- [Introduction](#introduction)
  - [Contributing](#contributing)
  - [Issues](#issues)

# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for [BIND](https://www.isc.org/downloads/bind/) DNS server.

BIND is open source software that implements the Domain Name System (DNS) protocols for the Internet. It is a reference implementation of those protocols, but it is also production-grade software, suitable for use in high-volume and high-reliability applications.

## Contributing

This docker is based on https://github.com/sameersbn/docker-bind
If you find this image useful here's how you can help:

- Send a pull request with your awesome features and bug fixes
- Help users resolve their [issues](../../issues?q=is%3Aopen+is%3Aissue).

## Issues

Before reporting your issue please try updating Docker to the latest version and check if it resolves the issue. Refer to the Docker [installation guide](https://docs.docker.com/installation) for instructions.

SELinux users should try disabling SELinux using the command `setenforce 0` to see if it resolves the issue.

If the above recommendations do not help then [report your issue](../../issues/new) along with the following information:

- Output of the `docker version` and `docker info` commands
- The `docker run` command or `docker-compose.yml` used to start the image. Mask out the sensitive bits.
- Please state if you are using [Boot2Docker](http://www.boot2docker.io), [VirtualBox](https://www.virtualbox.org), etc.

# Getting started

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/lansmash/bind) and is the recommended method of installation.

```bash
docker pull lansmash/bind:latest
```

Alternatively you can build the image yourself.
```bash
docker build -t lansmash/bind github.com/lansmash/docker-bind
```


## Quickstart

Start BIND using:

```bash
docker run --name bind -d --restart=always \
  --publish 53:53/tcp --publish 53:53/udp --publish 127.0.0.1:953:953 \
  --volume /srv/bind:/etc/bind \
  lansmash/bind
```

Watch the logs using:
```bash
docker logs -f bind
```

Reloading after config or zone changes:
```
 docker exec -it bind rndc reload
```
Alternatively, the rndc.key file can be symlinked into /etc/bind on the host and rndc can be run from the host if port 953 is exposed. 
Add the following to named.conf.local to allow rndc from anywhere:
```
controls { inet * allow { any; }; };

```
```bash
apt install bind9utils
ln -s /srv/bind/rndc.key /etc/bind/rndc.key
rndc reload
```

Read the blog post [Deploying a DNS Server using Docker](http://www.damagehead.com/blog/2015/04/28/deploying-a-dns-server-using-docker/) for an example use case.


## Persistence

For the BIND to preserve its state across container shutdown and startup you should mount a volume at `/data`. Change `/srv/docker/bind` to suit your needs.

> *The [Quickstart](#quickstart) command already mounts a volume for persistence.*

SELinux users should update the security context of the host mountpoint so that it plays nicely with Docker:

```bash
mkdir -p /srv/docker/bind
chcon -Rt svirt_sandbox_file_t /srv/docker/bind
```

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull lansmash/bind:latest
  ```

  2. Stop the currently running image:

  ```bash
  docker stop bind
  ```

  3. Remove the stopped container

  ```bash
  docker rm -v bind
  ```

  4. Start the updated image

  ```bash
  docker run -name bind -d \
    [OPTIONS] \
    lansmash/bind:latest
  ```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it bind bash
```
