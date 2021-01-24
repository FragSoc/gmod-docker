mkdir -p "${STEAMAPPDIR}" || true 


if [[ ! -d "${HOMEDIR}/css" ]]
then
    echo "CSS and TF2 not installed, installing"

    # CSS
    bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
                    +force_install_dir "${HOMEDIR}/css" \
                    +app_update "232330" \
                    +quit

    # TF2
    bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
                    +force_install_dir "${HOMEDIR}/tf2" \
                    +app_update "232250" \
                    +quit
fi

# GMOD
bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
				+force_install_dir "${STEAMAPPDIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

# Mount CSS and TF2
cp "${HOMEDIR}/mount.cfg" "${STEAMAPPDIR}/garrysmod/cfg/"

cd ${STEAMAPPDIR}

case "$GAMETYPE" in
    "TTT")
        echo "Configuring TTT Server"
        game_type="terrortown"
        workshop_collection="2120021421"
        default_map="ttt_minecraftcity_v4" ;;
    "Prop")
        echo "Configuring PropHunt Server"
        game_type="prophunters"
        workshop_collection="2120273717"
        default_map="ph_lotparking" ;;
    # Needs adding
    "Murder")
        echo "Configuring Murder Server"
        game_type="murder"
        workshop_collection="2120021421"
        default_map="" ;;
    "Homicide")
        echo "Configuring Homicide Server"
        game_type="homicide"
        workshop_collection="2120176172"
        default_map="ttt_Clue_se" ;;
    *)
        echo "No gametype was set so running sandbox"
        game_type="sandbox"
        workshop_collection=""
        default_map="gm_flatgrass" ;;
esac

# Run GMOD
bash "${STEAMAPPDIR}/srcds_run" -game "${STEAMAPP}" -console -autoupdate \
			-steam_dir "${STEAMCMDDIR}" \
			-steamcmd_script "${HOMEDIR}/${STEAMAPP}_update.txt" \
			-usercon \
			-port "${SRCDS_PORT}" \
            +gamemode "$game_type" \
			+map "$default_map" \
            +host_workshop_collection "$workshop_collection" \
			+sv_setsteamaccount "${SRCDS_TOKEN}"


