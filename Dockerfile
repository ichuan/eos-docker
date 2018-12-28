FROM ubuntu:18.04

WORKDIR /opt
VOLUME /opt/data /opt/wallet
EXPOSE 8888 8889

RUN apt-get update && apt-get install -y wget
RUN wget -O eos.deb https://github.com/EOSIO/eos/releases/download/v1.5.2/eosio_1.5.2-1-ubuntu-18.04_amd64.deb
RUN dpkg -i ./eos.deb; exit 0
RUN rm -f ./eos.deb && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /opt
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
