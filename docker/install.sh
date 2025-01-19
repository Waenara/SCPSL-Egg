#!/bin/bash

###############################################################
#                     Waenara / SCPSL-Egg                     #
#   Pterodactyl egg for simplified SCP:SL server management   #
#         Created by Waenara -- waenara.dev@gmail.com         #
###############################################################

# Install dependencies
apt-get update
apt-get install -y curl wget unzip libicu-dev lib32gcc-s1
apt-get clean
rm -rf /var/lib/apt/lists/*

# Remove old app directory and create a new one
rm -rf /mnt/server/.bin
mkdir -p /mnt/server/.bin

# Create startup script
cat << 'EOF' > /mnt/server/.bin/start.sh
if [ "$SCPDISCORD_INSTALLATION" -eq 1 ]; then
  /home/container/.bin/SCPDiscord/SCPDiscordBot_Linux --config /home/container/.config/SCPDiscord/config.yml &
fi

cd /home/container/.bin/SCPSLDS && /home/container/.bin/SCPSLDS/LocalAdmin "$SERVER_PORT"
EOF
chmod +x /mnt/server/.bin/start.sh

# Download SteamCMD
mkdir -p /mnt/server/.bin/SteamCMD
cd /mnt/server/.bin/SteamCMD
curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# Download SCP:Secret Laboratory Dedicated Server
./steamcmd.sh +force_install_dir /mnt/server/.bin/SCPSLDS +login anonymous +app_update 996560 -beta "$BETA_NAME" $( [ "$BETA_PASSWORD" != "none" ] && echo "-betapassword $BETA_PASSWORD" ) validate +quit

# Download Exiled
if [ "$EXILED_INSTALLATION" -ne 0 ]; then
    mkdir -p /mnt/server/.bin/ExiledInstaller
    cd /mnt/server/.bin/ExiledInstaller
    wget https://github.com/ExMod-Team/EXILED/releases/latest/download/Exiled.Installer-Linux
    chmod +x Exiled.Installer-Linux
    ./Exiled.Installer-Linux --path /mnt/server/.bin/SCPSLDS --appdata /mnt/server/.config/ --exiled /mnt/server/.config/ $([ "$EXILED_INSTALLATION" -eq 2 ] && echo --pre-releases)
fi

# Install Discord bot
if [ "$SCPDISCORD_INSTALLATION" -eq 1 ]; then
    mkdir -p /mnt/server/.bin/SCPDiscord
    cd /mnt/server/.bin/SCPDiscord
    wget https://github.com/KarlOfDuty/SCPDiscord/releases/latest/download/SCPDiscordBot_Linux
    chmod +x SCPDiscordBot_Linux
    mkdir -p /mnt/server/.config/SCPDiscord

    mkdir -p /mnt/server/.config/'SCP Secret Laboratory'/PluginAPI/plugins/global/
    cd /mnt/server/.config/'SCP Secret Laboratory'/PluginAPI/plugins/global/
    wget https://github.com/KarlOfDuty/SCPDiscord/releases/latest/download/dependencies.zip
    unzip -o dependencies.zip -d /mnt/server/.config/'SCP Secret Laboratory'/PluginAPI/plugins/global/
    rm -f dependencies.zip
    rm -f /mnt/server/.config/'SCP Secret Laboratory'/PluginAPI/plugins/global/SCPDiscord.dll
    wget https://github.com/KarlOfDuty/SCPDiscord/releases/latest/download/SCPDiscord.dll
else
    rm /mnt/server/.config/'SCP Secret Laboratory'/PluginAPI/plugins/global/SCPDiscord.dll
fi