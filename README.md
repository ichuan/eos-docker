# eos-docker
Docker builds for eos, since the [official one](https://hub.docker.com/r/eosio/eos) is sunsetting.

We expose nodeos at port 8888, and keosd at 8889.

## Build

```
docker build -t eos:1.5.2 .
```

## Run

```
mkdir data wallet
# watch account `binancecleos` for query actions
docker run --rm -itd --name ieos -e "watch_account=binancecleos" -p 0.0.0.0:8888:8888 -p 0.0.0.0:8889:8889 -v `pwd`/data:/opt/data -v `pwd`/wallet:/opt/wallet eos
```

## Persist data

By using [CWSpear/local-persist](https://github.com/CWSpear/local-persist):

```
curl -fsSL https://raw.githubusercontent.com/CWSpear/local-persist/master/scripts/install.sh | sudo bash
docker volume create -d local-persist -o mountpoint=/data/eos-data --name=eos-data
docker volume create -d local-persist -o mountpoint=/data/eos-wallet --name=eos-wallet
```

## Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/eos/>:

```
docker run --rm -itd --name ieos -e "watch_account=binancecleos" -p 0.0.0.0:8888:8888 -p 0.0.0.0:8889:8889 -v eos-data:/opt/data -v eos-wallet:/opt/wallet mixhq/eos
```

## Reference
- `mainnet-genesis.json` is from <https://github.com/EOS-Mainnet/eos/blob/mainnet-1.5.1/mainnet-genesis.json>
- `p2p-peer-address` is from <https://eosnodes.privex.io/>
