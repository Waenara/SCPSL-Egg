#!/bin/bash

echo "###############################################################"
echo "#                     Waenara / SCPSL-Egg                     #"
echo "#   Pterodactyl egg for simplified SCP:SL server management   #"
echo "#         Created by Waenara -- waenara.dev@gmail.com         #"
echo "###############################################################"

# Install dependencies
apt-get update
apt-get install -y unzip libicu-dev lib32gcc-s1
apt-get clean
rm -rf /var/lib/apt/lists/*

# Remove old binaries
rm -rf /mnt/server/.bin

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
    curl -L "https://github.com/ExSLMod-Team/EXILED/releases/latest/download/Exiled.Installer-Linux" -o Exiled.Installer-Linux
    chmod +x Exiled.Installer-Linux
    ./Exiled.Installer-Linux --path /mnt/server/.bin/SCPSLDS --appdata /mnt/server/.config/ --exiled /mnt/server/.config/ $([ "$EXILED_INSTALLATION" -eq 2 ] && echo --pre-releases)
fi

# Install Discord bot - USING TAG 3.3.0-RC5 FOR NOW AS THERES NO STABLE RELEASE FOR LABAPI YET
if [ "$SCPDISCORD_INSTALLATION" -eq 1 ]; then
    mkdir -p /mnt/server/.bin/SCPDiscord
    cd /mnt/server/.bin/SCPDiscord
    curl -L "https://github.com/KarlOfDuty/SCPDiscord/releases/download/3.3.0-RC5/SCPDiscordBot_Linux_SC" -o SCPDiscordBot_Linux_SC
    chmod +x SCPDiscordBot_Linux_SC
    mkdir -p /mnt/server/.config/SCPDiscord

    mkdir -p "/mnt/server/.config/SCP Secret Laboratory/LabAPI/dependencies/global/"
    cd "/mnt/server/.config/SCP Secret Laboratory/LabAPI/"
    curl -L "https://github.com/KarlOfDuty/SCPDiscord/releases/download/3.3.0-RC5/dependencies.zip" -o dependencies.zip
    unzip -o dependencies.zip "dependencies/*" -d temp_extracted
    mv -f temp_extracted/dependencies/* "dependencies/global/"
    rm -rf dependencies.zip temp_extracted
    
    rm -f /mnt/server/.config/'SCP Secret Laboratory'/LabAPI/plugins/global/SCPDiscord.dll
    curl -L "https://github.com/KarlOfDuty/SCPDiscord/releases/download/3.3.0-RC5/SCPDiscord.dll" -o SCPDiscord.dll
else
    rm /mnt/server/.config/'SCP Secret Laboratory'/LabAPI/plugins/global/SCPDiscord.dll
fi

# Remove installation files
rm -rf /mnt/server/.bin/SteamCMD
rm -rf /mnt/server/.bin/ExiledInstaller

echo "###############################################################"
echo "#                   Installation completed!                   #"
echo "###############################################################"
