#!/usr/bin/env bash

set -e

# keosd
keosd --wallet-dir /opt/wallet \
  --http-validate-host=false \
  --http-server-address=0.0.0.0:8889 \
  --unlock-timeout 315360000 &

# using snapshot from eosnode.tools
# non-jq equivalent commands (without curl, cause not installed)
json=`wget -q 'https://eosnode.tools/api/snapshots?limit=1' -O -| sed 's/"/\\\"/g'`
url=`wget 'https://jqplay.org/jq' -q --header 'Content-Type: application/json;charset=UTF-8' --header 'Accept: application/json, text/plain' --header 'Referer: https://jqplay.org/' --post-data "{\"j\":\"${json}\",\"q\":\".data[0].s3\",\"o\":[{\"name\":\"raw-output\",\"enabled\":true}]}" -O -`
wget "$url" -O - | tar xzf -

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
  --snapshot snapshots/snapshot-*.bin \
  --p2p-peer-address = 18.234.6.119:80 \
  --p2p-peer-address = api-full1.eoseoul.io:9876 \
  --p2p-peer-address = api-full2.eoseoul.io:9876 \
  --p2p-peer-address = boot.eostitan.com:9876 \
  --p2p-peer-address = bp.cryptolions.io:9876 \
  --p2p-peer-address = bp.eosbeijing.one:8080 \
  --p2p-peer-address = br.eosrio.io:9876 \
  --p2p-peer-address = eos-seed-de.privex.io:9876 \
  --p2p-peer-address = eu1.eosdac.io:49876 \
  --p2p-peer-address = fullnode.eoslaomao.com:443 \
  --p2p-peer-address = mainnet.eoscalgary.io:5222 \
  --p2p-peer-address = node.eosflare.io:1883 \
  --p2p-peer-address = node1.eoscannon.io:59876 \
  --p2p-peer-address = p2p.eosdetroit.io:3018 \
  --p2p-peer-address = p2p.genereos.io:9876 \
  --p2p-peer-address = p2p.meet.one:9876 \
  --p2p-peer-address = peer.eosn.io:9876 \
  --p2p-peer-address = peer.main.alohaeos.com:9876 \
  --p2p-peer-address = peer1.mainnet.helloeos.com.cn:80 \
  --p2p-peer-address = peer2.mainnet.helloeos.com.cn:80 \
  --p2p-peer-address = publicnode.cypherglass.com:9876 \
  --p2p-peer-address = seed1.greymass.com:9876 \
  --p2p-peer-address = seed2.greymass.com:9876
