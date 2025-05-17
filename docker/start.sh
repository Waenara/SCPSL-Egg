#!/bin/bash

# Update SCP: Secret Laboratory Dedicated Server
cd .bin/SteamCMD && \
./steamcmd.sh +force_install_dir .bin/SCPSLDS +login anonymous +app_update 996560 -beta "$BETA_NAME" $( [ "$BETA_PASSWORD" != "none" ] && echo "-betapassword $BETA_PASSWORD" ) validate +quit && \
rm -rf Steam

# Start SCPDiscord if enabled
if [ "$SCPDISCORD_INSTALLATION" -eq 1 ]; then
  .bin/SCPDiscord/SCPDiscordBot_Linux_SC --config .config/SCPDiscord/config.yml &
fi

# Start SCP: Secret Laboratory Dedicated Server
cd .bin/SCPSLDS && .bin/SCPSLDS/LocalAdmin "$SERVER_PORT"
