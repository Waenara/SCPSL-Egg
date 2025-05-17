###############################################################
#                     Waenara / SCPSL-Egg                     #
#   Pterodactyl egg for simplified SCP:SL server management   #
#         Created by Waenara -- waenara.dev@gmail.com         #
###############################################################

# Use the latest Ubuntu image as base
FROM debian:stable-slim

# Update the package list and install dependencies
RUN apt-get update
RUN apt-get install -y adduser libicu-dev lib32gcc-s1
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Creating a container user
RUN adduser --disabled-password --home /home/container container
USER container
ENV USER=container HOME=/home/container

# Set the working directory
WORKDIR /home/container

# Copy and execute the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]