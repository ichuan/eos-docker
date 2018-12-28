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
docker run --rm -itd --name ieos -p 0.0.0.0:8888:8888 -p 0.0.0.0:8889:8889 -v `pwd`/data:/opt/data -v `pwd`/wallet:/opt/wallet eos
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
docker run --rm -itd --name ieos -p 0.0.0.0:8888:8888 -p 0.0.0.0:8889:8889 -v `pwd`/data:/opt/data -v `pwd`/wallet:/opt/wallet mixhq/eos
```
