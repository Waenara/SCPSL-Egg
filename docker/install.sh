#!/bin/bash

# Begin of installation
echo "###############################################################"
echo "#                     Waenara / SCPSL-Egg                     #"
echo "#   Pterodactyl egg for simplified SCP:SL server management   #"
echo "#         Created by Waenara -- waenara.dev@gmail.com         #"
echo "###############################################################"

# Install dependencies
apt-get update
apt-get install -y curl wget unzip libicu-dev lib32gcc-s1
apt-get clean
rm -rf /var/lib/apt/lists/*

# Remove old binaries
rm -rf /mnt/server/.bin

# Download setup files
cd /mnt/server
curl -L https://github.com/Waenara/SCPSL-Egg/archive/refs/heads/main.zip -o repo.zip
unzip repo.zip "SCPSL-Egg-main/docker/setup/*" -d .
mv -v SCPSL-Egg-main/docker/setup/.[!.]* .
rm -rf repo.zip SCPSL-Egg-main

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

# End of installation
echo "###############################################################"
echo "#                   Installation completed!                   #"
echo "###############################################################"