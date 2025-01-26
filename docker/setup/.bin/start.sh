#!/bin/bash

# Update SCP: Secret Laboratory Dedicated Server
cd /home/container/.bin/SteamCMD && ./steamcmd.sh +force_install_dir /home/container/.bin/SCPSLDS +login anonymous +app_update 996560 -beta "$BETA_NAME" $( [ "$BETA_PASSWORD" != "none" ] && echo "-betapassword $BETA_PASSWORD" ) validate +quit
rm -rf /home/container/Steam

# Run plugin installer
cd /home/container/.bin/PluginInstaller && bash start.sh

# Start SCPDiscord if enabled
if [ "$SCPDISCORD_INSTALLATION" -eq 1 ]; then
  /home/container/.bin/SCPDiscord/SCPDiscordBot_Linux --config /home/container/.config/SCPDiscord/config.yml &
fi

# Start SCP: Secret Laboratory Dedicated Server
cd /home/container/.bin/SCPSLDS && /home/container/.bin/SCPSLDS/LocalAdmin "$SERVER_PORT"