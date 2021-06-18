FROM ubuntu:18.04

# Set Debian Frontend
ENV DEBIAN_FRONTEND=noninteractive

# BUILD ARGs
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

# MYSTERIUM NETWORK ENV
ENV OS_DIR_CONFIG="/etc/mysterium-node"
ENV OS_DIR_DATA="/var/lib/mysterium-node"
ENV OS_DIR_RUN="/var/run/mysterium-node"

# Labels
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.description="Mysterium Network Node docker image multiarch (unofficial)" \
    org.label-schema.name="xpecex/myst-node" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.usage="https://github.com/xpecex/myst-node" \
    org.label-schema.vcs-url="https://github.com/xpecex/myst-node" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vendor="xPeCex" \
    org.label-schema.version=$VERSION

# Install Dependencies
RUN apt update && \
    apt upgrade -yqq && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
    apt install -yqq wget openvpn wireguard resolvconf iptables iproute2 sudo wireguard libcap2-bin && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

# Copy Download file
COPY download.sh /tmp/download.sh

# Install Mysterium-Node
RUN chmod +x /tmp/download.sh && \
    ./tmp/download.sh && \
    dpkg -i /tmp/myst_linux_$VERSION.deb && \
    apt install -f -yqq && \
    mkdir -p $OS_DIR_CONFIG && \
    mkdir -p $OS_DIR_DATA && \
    mkdir -p $OS_DIR_RUN && \
    ln -s /lib/ld-linux-*.so.3 /lib/ld-linux.so.3 && \
    rm -rf /tmp/*

# Download Entrypoint and prepare-env scripts
ADD https://raw.githubusercontent.com/mysteriumnetwork/node/master/bin/docker/docker-entrypoint.sh /docker-entrypoint.sh
ADD https://raw.githubusercontent.com/mysteriumnetwork/node/master/bin/helpers/prepare-run-env.sh /usr/local/bin/prepare-run-env.sh

# Change permissions
RUN chmod +x /docker-entrypoint.sh && \
    chmod +x /usr/local/bin/prepare-run-env.sh

# Set default entrypoint
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# EXPOSE
EXPOSE 4449