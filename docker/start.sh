#!/bin/bash

# Start SCPDiscord if enabled
if [ "$SCPDISCORD_INSTALLATION" -eq 1 ]; then
    /home/container/.bin/SCPDiscord/SCPDiscordBot_Linux_SC --config /home/container/.config/SCPDiscord/config.yml &
fi

# Start SCP: Secret Laboratory Dedicated Server
cd /home/container/.bin/SCPSLDS && /home/container/.bin/SCPSLDS/LocalAdmin "$SERVER_PORT"
