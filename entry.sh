#!/usr/bin/env bash
set -euxo pipefail

# Run GMOD, passing commands through
./srcds_run -game garrysmod -console -autoupdate \
    -usercon \
    -port 27015 \
    +gamemode "${GAMETYPE}" \
    +map "${DEFAULT_MAP}" \
    +host_workshop_collection "${WORKSHOP_COLLECTION}" \
    +rcon_password "${RCON_PWD}" \
    +sv_setsteamaccount "${SRCDS_TOKEN}" \
    "$@"
