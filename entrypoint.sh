#!/bin/bash -e

bw config server ${BW_HOST}

export BW_SESSION=$(bw login ${BW_USER} --passwordenv BW_PASSWORD --raw)

bw unlock --check

BW_PORT="${BW_PORT:-8087}"
BW_HOSTNAME="${BW_HOSTNAME:-0.0.0.0}"
if [ "$#" -lt "1" ]; then
    exec  tini -- bw serve --port ${BW_PORT} --hostname ${BW_HOSTNAME}
fi

exec tini -- bw $@
