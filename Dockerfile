FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG ARIA_VERSION=0.3.1
ARG ARIA_TARBALL_URL=https://pool.ariabrain.com/downloads/aria-csd-miner-v0.3.1-d7f845666ae549c1.tar.gz

LABEL org.opencontainers.image.version="${ARIA_VERSION}"

ENV DEBIAN_FRONTEND=noninteractive \
    ARIA_VERSION=${ARIA_VERSION} \
    ARIA_POOL=csd.ariabrain.com:13333 \
    ARIA_ADDRESS= \
    ARIA_WORKER= \
    ARIA_GPU= \
    ARIA_THREADS=

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tar \
    bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/aria
RUN curl -A 'Mozilla/5.0' -fsSL "$ARIA_TARBALL_URL" -o /tmp/aria.tgz \
    && tar -xzf /tmp/aria.tgz -C /opt \
    && rm -f /tmp/aria.tgz \
    && find /opt -maxdepth 3 -type f -name 'aria-csd-miner' -exec chmod +x {} +

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
