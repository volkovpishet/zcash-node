FROM debian:jessie-slim
MAINTAINER Ville Törhönen <ville@torhonen.fi>

# Install dependencies
# Separate layer so we can cache things
RUN set -x && \
    apt-get update && \
    apt-get -y install \
      apt-transport-https \
      git \
      wget \
    rm -rf /var/lib/apt/lists/* \
    wget -qO - https://apt.z.cash/zcash.asc | sudo apt-key add - \
    echo "deb [arch=amd64] https://apt.z.cash/ jessie main" | sudo tee /etc/apt/sources.list.d/zcash.list \
    apt-get update && \
    apt-get -y install \
      zcash \

RUN set -x && \
    bash zcash-fetch-params

# create dirs
    RUN  mkdir -p /zcash/data && \
    mkdir -p /root/.zcash 

# Use custom entrypoint
WORKDIR /zcash
COPY docker-entrypoint.sh /zcash/docker-entrypoint.sh
ENTRYPOINT [ "/zcash/docker-entrypoint.sh" ]