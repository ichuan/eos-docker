# eos-docker
Docker builds for eos.

We expose nodeos at port 8888, and keosd at 8889.

## Build

```
docker build -t eos .
```

## Run

```
mkdir data wallet
# watch account `binancecleos` for query actions
docker run --rm -itd --name ieos -e "watch_account=binancecleos" -p 8888:8888 -p 8889:8889 -v `pwd`/data:/opt/data -v `pwd`/wallet:/opt/wallet eos
```

## Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/eos/>:

```
docker run --rm -itd --name ieos -e "watch_account=binancecleos" -p 8888:8888 -p 8889:8889 -v `pwd`/data:/opt/data -v `pwd`/wallet:/opt/wallet mixhq/eos
```


## Using latest blockchain snapshot to speedup sync

Using snapshots from:
- <https://snapshots.eossweden.org/>
- <https://snapshots.eosnation.io/>

Steps:
- First, delete `blocks` and `state` dir

    ```
    rm -rf /data/eos-data/*
    ```
- Start with latest snapshot

    ```
    docker run --rm -itd --name ieos -e "watch_account=binancecleos" -p 8888:8888 -p 8889:8889 -v `pwd`/data:/opt/data -v `pwd`/wallet:/opt/wallet -v $PWD/start_from_latest_snapshot.sh:/start_from_latest_snapshot.sh mixhq/eos /start_from_latest_snapshot.sh
    ```

- Later, you can start with normal `docker run` commands


## Reference
- `mainnet-genesis.json` is from <https://github.com/EOS-Mainnet/eos/blob/mainnet-1.5.1/mainnet-genesis.json>
- `p2p-peer-address` is from <https://eosnodes.privex.io/>
