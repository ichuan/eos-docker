#!/usr/bin/env bash

set -e

if test $# -eq 0; then
  # keosd
  keosd --wallet-dir /opt/wallet \
    --http-validate-host=false \
    --http-server-address=0.0.0.0:8889 \
    --unlock-timeout 315360000 &
  # nodeos (768G state db)
  receiver=${watch_account:-eosio.token}
  exec nodeos -e -p eosio \
    --plugin eosio::chain_plugin \
    --plugin eosio::chain_api_plugin \
    --plugin eosio::history_plugin \
    --plugin eosio::history_api_plugin \
    --filter-on ${receiver}:transfer: \
    --data-dir /opt/data \
    --chain-state-db-size-mb 786432 \
    --reversible-blocks-db-size-mb 2048 \
    --max-clients 150 \
    --sync-fetch-span 2000 \
    --http-server-address=0.0.0.0:8888 \
    --http-validate-host=false \
    --access-control-allow-origin=* \
    --contracts-console \
    --genesis-json /opt/mainnet-genesis.json \
    --p2p-peer-address api-full1.eoseoul.io:9876 \
    --p2p-peer-address api-full2.eoseoul.io:9876 \
    --p2p-peer-address boot.eostitan.com:9876 \
    --p2p-peer-address bp.cryptolions.io:9876 \
    --p2p-peer-address bp.eosbeijing.one:8080 \
    --p2p-peer-address bp.libertyblock.io:9800 \
    --p2p-peer-address br.eosrio.io:9876 \
    --p2p-peer-address eos-seed-de.privex.io:9876 \
    --p2p-peer-address eu1.eosdac.io:49876 \
    --p2p-peer-address fullnode.eoslaomao.com:443 \
    --p2p-peer-address mainnet.eoscalgary.io:5222 \
    --p2p-peer-address node.eosflare.io:1883 \
    --p2p-peer-address node1.eoscannon.io:59876 \
    --p2p-peer-address p2p.eosdetroit.io:3018 \
    --p2p-peer-address p2p.genereos.io:9876 \
    --p2p-peer-address p2p.meet.one:9876 \
    --p2p-peer-address peer.eosn.io:9876 \
    --p2p-peer-address peer.main.alohaeos.com:9876 \
    --p2p-peer-address peer1.mainnet.helloeos.com.cn:80 \
    --p2p-peer-address peer2.mainnet.helloeos.com.cn:80 \
    --p2p-peer-address peering.mainnet.eoscanada.com:9876 \
    --p2p-peer-address peering1.mainnet.eosasia.one:80 \
    --p2p-peer-address peering2.mainnet.eosasia.one:80 \
    --p2p-peer-address seed1.greymass.com:9876 \
    --p2p-peer-address seed2.greymass.com:9876
else
  exec $@
fi
