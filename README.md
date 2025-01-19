<p align="center">
  <img src="https://shared.cloudflare.steamstatic.com/store_item_assets/steam/apps/700330/header.jpg?t=1737064460" alt="SCP: Secret Laboratory" style="border-radius: 15px; max-width: 100%; height: auto;">
</p>

<h1 align="center">SCPSL-Egg</h1>

<p align="center">
  A Pterodactyl egg that simplifies the deployment and management of <a href="https://store.steampowered.com/app/700330/SCP_Secret_Laboratory/">SCP: Secret Laboratory (SCP:SL)</a> game servers using the <a href="https://pterodactyl.io/">Pterodactyl panel</a>.
</p>

<p align="center">
  <img src="https://github.com/Waenara/SCPSL-Egg/actions/workflows/docker-image.yml/badge.svg" alt="Build Status">
</p>

## Features
- Simple, lightweight, and easy to use.
- Clean and organized file structure.
- Automatically installs [SteamCMD](https://developer.valvesoftware.com/wiki/Ru/SteamCMD) and it's dependencies.
- Automatically installs [SCP: Secret Laboratory Dedicated Server](https://steamdb.info/app/996560/info/) and it's dependencies. You can configure branch and branch password in server variables
- Automatically installs [EXILED](https://github.com/ExMod-Team/EXILED) using official [EXILED Installer](https://github.com/ExMod-Team/EXILED/tree/master/EXILED/Exiled.Installer) if configured in server variables.
- Automatically installs [SCPDiscord](https://github.com/KarlOfDuty/SCPDiscord) and it's dependencies if configured in server variables.

## Installation
1. Download `SCPSL-Egg.json` file from this repository.
2. Go to your [Pterodactyl panel](https://pterodactyl.io/) and navigate to `Admin Panel` -> `Nests` -> `Create New` and fill the necessary fields.
3. Click on the `Import Egg` button (On the main `Nests` page), select the `SCPSL-Egg.json` file you downloaded and choose the `SCP: Secret Laboratory` nest you created.
4. Сreate a new server, select the `SCP: Secret Laboratory` egg, and configure the necessary variables.
5. Wait for the server to install and enjoy!

## Variables
> [!IMPORTANT]
> If you change values after the server is installed, you will need to reinstall the server for the changes to take effect. This won't delete any data on the server, except the `.bin` folder.

- `Exiled Installation Variant` - Defines the installation option for the Exiled framework. Available options: 
```
0: Do not install Exiled.
1: Install the stable release version of Exiled.
2: Install the pre-release version of Exiled.
```
- `Use SCPDiscord?` - Defines whether to install and use SCPDiscord plugin.
- `Beta name` - Specifies the SteamCMD beta branch name for the server installation. Enter the name of the desired beta branch to use. Use `public` to select the public branch.
- `Beta password` - Specifies the SteamCMD beta password for the server installation. Enter the password required to access the selected beta branch. Use "none" if no password is required.