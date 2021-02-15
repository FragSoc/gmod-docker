#!/usr/bin/env bash

# Update/install gmod itself
bash steamcmd +login anonymous \
    +force_install_dir /garrysmod \
    +app_update 4020 validate \
    +quit

# Mount CSS and TF2
ln -s "${MOUNT_CONFIG}" /garrysmod/cfg/mount.cfg

# Run GMOD, passing commands through
./srcds_run -game garrysmod -console -autoupdate \
    -steam_dir "${STEAMCMDDIR}" \
    -steamcmd_script "${UPDATE_SCRIPT}" \
    -usercon \
    -port 27015 \
    +gamemode "${GAMETYPE}" \
    +map "${DEFAULT_MAP}" \
    +host_workshop_collection "${WORKSHOP_COLLECTION}" \
    +rcon_password "${RCON_PWD}" \
    +sv_setsteamaccount "${SRCDS_TOKEN}" \
    $@
