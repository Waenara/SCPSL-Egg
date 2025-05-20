###############################################################
#                     Waenara / SCPSL-Egg                     #
#   Pterodactyl egg for simplified SCP:SL server management   #
#         Created by Waenara -- waenara.dev@gmail.com         #
###############################################################

FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends adduser libicu-dev ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    update-ca-certificates && \
    adduser --disabled-password --home /home/container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
