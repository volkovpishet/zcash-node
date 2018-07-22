#!/bin/sh
: ${CONTAINER_NAME:="zcash-node_zcash_1"}
docker exec ${CONTAINER_NAME} zcash-cli "$@"
