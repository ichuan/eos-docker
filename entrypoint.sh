#!/usr/bin/env bash

set -e

if test $# -eq 0; then
  # keosd
  keosd --wallet-dir /opt/wallet \
    --http-validate-host=false \
    --http-server-address=0.0.0.0:8889 \
    --unlock-timeout 315360000 &
  # nodeos
  exec nodeos -e -p eosio \
    --plugin eosio::chain_plugin \
    --plugin eosio::chain_api_plugin \
    --plugin eosio::history_plugin \
    --plugin eosio::history_api_plugin \
    --filter-on eosio.token:transfer: \
    --data-dir /opt/data \
    --http-server-address=0.0.0.0:8888 \
    --http-validate-host=false
    --access-control-allow-origin=* \
    --contracts-console \
    --http-validate-host=false \
    --filter-on='*'
else
  exec $@
fi
