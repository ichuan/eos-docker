FROM ubuntu:18.04

WORKDIR /opt
VOLUME /opt/data /opt/wallet
EXPOSE 8888 8889

RUN apt-get update && apt-get install -y wget
RUN wget -O eos.deb https://github.com/EOSIO/eos/releases/download/v2.1.0/eosio_2.1.0-1-ubuntu-18.04_amd64.deb
RUN dpkg -i ./eos.deb; exit 0
RUN apt install -f -y
RUN rm -f ./eos.deb && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh ./mainnet-genesis.json /opt/
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
