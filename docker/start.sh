#!/bin/bash

# Start SCPDiscord if enabled
if [ "$SCPDISCORD_INSTALLATION" -eq 1 ]; then
  .bin/SCPDiscord/SCPDiscordBot_Linux_SC --config .config/SCPDiscord/config.yml &
fi

# Start SCP: Secret Laboratory Dedicated Server
cd .bin/SCPSLDS && .bin/SCPSLDS/LocalAdmin "$SERVER_PORT"
