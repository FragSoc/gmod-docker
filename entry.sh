mkdir -p "${STEAMAPPDIR}" || true


if [[ ! -d "${HOMEDIR}/css" ]]
then
    echo "CSS and TF2 not installed, installing"

    # CSS
    bash "${STEAMCMDDIR}/steamcmd.sh" \
	+login anonymous \
	+force_install_dir "${HOMEDIR}/css" \
	+app_update "232330" \
	+quit

    # TF2
    bash "${STEAMCMDDIR}/steamcmd.sh" \
	+login anonymous \
	+force_install_dir "${HOMEDIR}/tf2" \
	+app_update "232250" \
	+quit
fi

# Mount CSS and TF2
cp "${HOMEDIR}/mount.cfg" "${STEAMAPPDIR}/garrysmod/cfg/"

cd ${STEAMAPPDIR}

# Run GMOD
./srcds_run -game garrysmod -console -autoupdate \
    -steam_dir "$(pwd)" \
    -steamcmd_script "${HOMEDIR}/garrysmod_update.txt" \
    -usercon \
    -port "${SRCDS_PORT}" \
    +rcon_password "${RCON_PWD}" \
    +sv_setsteamaccount "${SRCDS_TOKEN}" $@
