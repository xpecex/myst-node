# myst-node

### What is myst-node image?

> myst-node is a multi-architecture docker image containing the official Mysterium-Network Node binary.

### What is Mysterium-Network?

> **Mysterium** is building a decentralised P2P VPN and other tools that allow you to browse the internet freely, earn by sharing your connection, and build censorship-resistant applications.
> Learn more: [https://mysterium.network/](https://mysterium.network/)


### Tags:
 - latest
 - 0.47.2

### How to use this image

```shell
docker run -d \
--cap-add NET_ADMIN \
--net host \
--name myst \
-v /your_path/data/:/var/lib/mysterium-node \
-v /your_path/run/:/var/run/mysterium-node \
xpecex/myst-node:latest \
service --openvpn.port 1194 --agreed-terms-and-conditions $SERVICE_OPTS
````
*NOTE: replace **your_path** with the path you prefer to save myst-node configuration and data files*

### How to build a local image

```shell
$ git clone https://github.com/xpecex/myst-node.git
$ cd myst-node
$ chmod +x build.sh

# Building a multi-arch image requires buildx 
# see more here: https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/
$ VERSION=X.X.X DOCKER_USER=docker_username DOCKER_PASSWORD=docker_password ALT_NAME="docker_username/image_name" ./build.sh

# Building a single architecture image
$ VERSION=X.X.X docker build \
--build-arg VERSION="$VERSION" \
--build-arg VCS_REF="$VCS_REF" \
--build-arg BUILD_DATE="$BUILD_DATE" \
--cache-from $NAME:$RELEASE \
--tag "$NAME:$RELEASE" \
--tag "$NAME:latest" \
.
````

NOTE: Replace variables as per your needs

-------------
[![Donate with Ethereum](https://en.cryptobadges.io/badge/small/0xE32cACcB768a3E65e83B3AF39ca31f446C06432D)](https://en.cryptobadges.io/donate/0xE32cACcB768a3E65e83B3AF39ca31f446C06432D)
[![Donate with Bitcoin](https://en.cryptobadges.io/badge/small/1E7HYMUCf3DD7kcpkyY38tzUzT2F8w1Rg7)](https://en.cryptobadges.io/donate/1E7HYMUCf3DD7kcpkyY38tzUzT2F8w1Rg7)
