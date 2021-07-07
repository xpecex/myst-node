FROM ubuntu:18.04

# Set Debian Frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install Dependencies
RUN apt update && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
    apt install --no-install-recommends -yqq wget openvpn wireguard resolvconf iptables iproute2 sudo wireguard libcap2-bin ca-certificates && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

# BUILD ARGs
ARG TARGETPLATFORM
ARG IMAGE_NAME
ARG IMAGE_VER
ARG IMAGE_AUTHOR
ARG IMAGE_VENDOR
ARG IMAGE_REF
ARG IMAGE_DESC
ARG IMAGE_BUILD_DATE
ARG IMAGE_URL
ARG IMAGE_LICENSE

# Labels
LABEL org.opencontainers.image.title="$IMAGE_NAME" \
    org.opencontainers.image.authors="$IMAGE_AUTHOR" \
    org.opencontainers.image.vendor="$IMAGE_VENDOR" \
    org.opencontainers.image.description="$IMAGE_DESC" \
    org.opencontainers.image.created="$IMAGE_BUILD_DATE" \
    org.opencontainers.image.url="$IMAGE_URL" \
    org.opencontainers.image.source="$IMAGE_URL" \
    org.opencontainers.image.documentation="$IMAGE_URL" \
    org.opencontainers.image.revision="$IMAGE_REF" \
    org.opencontainers.image.version="$IMAGE_VER" \
    org.opencontainers.image.licenses="$IMAGE_LICENSE"

# COPY Entrypoint and prepare-env scripts
COPY $TARGETPLATFORM/myst_node.deb /tmp/myst_node.deb
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY prepare-run-env.sh /usr/local/bin/prepare-run-env.sh

# Install Mysterium-Node
RUN dpkg -i /tmp/myst_node.deb && \
    ln -s /lib/ld-linux-*.so.3 /lib/ld-linux.so.3 && \
    rm -rf /tmp/*

# Set default entrypoint
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# EXPOSE
EXPOSE 4449