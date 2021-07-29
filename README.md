# myst-node
![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/xpecex/myst-node/latest)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/xpecex/myst-node/latest)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/xpecex/myst-node/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/xpecex/myst-node)
![GitHub](https://img.shields.io/github/license/xpecex/myst-node)
[![](https://api.travis-ci.com/xpecex/myst-node.svg?branch=main)](https://travis-ci.com/github/xpecex/myst-node)

### What is myst-node image?

> myst-node is a multi-architecture docker image containing the official [Mysterium-Network Node binary](https://github.com/mysteriumnetwork/node).

### What is Mysterium-Network?

> **Mysterium** is building a decentralised P2P VPN and other tools that allow you to browse the internet freely, earn by sharing your connection, and build censorship-resistant applications.
> Learn more: [https://mysterium.network/](https://mysterium.network/)


### Tags:
 - latest
 - 0.53.0
 - 0.52.0
 - 0.51.0
 - 0.50.1
 - 0.49.0
 - 0.48.0
 - 0.47.3
 - 0.47.2
 - 0.47.1
 - 0.47.0


### How to use this image

```shell
docker run -d \
--cap-add NET_ADMIN \
--net host \
--name myst \
-v /your_path/data/:/var/lib/mysterium-node \
-v /your_path/run/:/var/run/mysterium-node \
xpecex/myst-node:latest \
service --agreed-terms-and-conditions
````
*NOTE: replace **your_path** with the path you prefer to save myst-node configuration and data files*

### How to build a local image

```shell
$ git clone https://github.com/xpecex/myst-node.git
$ cd myst-node
$ chmod +x build.sh

# Building a multi-arch image requires buildx 
# see more here: https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/
$ ./build.sh
````

NOTE: Replace variables in ```build.sh``` as per your needs

-------------
[![Donate with Ethereum](https://en.cryptobadges.io/badge/small/0xE32cACcB768a3E65e83B3AF39ca31f446C06432D)](https://en.cryptobadges.io/donate/0xE32cACcB768a3E65e83B3AF39ca31f446C06432D)
[![Donate with Bitcoin](https://en.cryptobadges.io/badge/small/1E7HYMUCf3DD7kcpkyY38tzUzT2F8w1Rg7)](https://en.cryptobadges.io/donate/1E7HYMUCf3DD7kcpkyY38tzUzT2F8w1Rg7)
