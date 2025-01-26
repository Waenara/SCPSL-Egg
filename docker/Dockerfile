###############################################################
#                     Waenara / SCPSL-Egg                     #
#   Pterodactyl egg for simplified SCP:SL server management   #
#         Created by Waenara -- waenara.dev@gmail.com         #
###############################################################

# Use the latest Ubuntu image as base
FROM ubuntu:latest

# Update the package list and install dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    wget \
    unzip \
    adduser \
    python3 \
    python3-pip \
    libicu-dev \
    lib32gcc-s1 \
    dotnet-sdk-8.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Creating a container user
RUN adduser --disabled-password --home /home/container container
USER container
ENV USER=container HOME=/home/container

# Set the working directory
WORKDIR /home/container

# Copy and execute the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]