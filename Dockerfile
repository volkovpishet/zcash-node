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

RUN wget -qO - https://apt.z.cash/zcash.asc
RUN apt-key add rabbitmq-signing-key-public.asc
RUN echo "deb [arch=amd64] https://apt.z.cash/ jessie main" | tee /etc/apt/sources.list.d/zcash.list \
RUN set -x && \
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