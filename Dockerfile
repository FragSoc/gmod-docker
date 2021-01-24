#####################################################################
# Dockerfile that builds a GMOD Gameserver - modified from CS Scrim #
#####################################################################
FROM cm2network/steamcmd:root

ENV STEAMAPPID 4020
ENV STEAMAPP garrysmod
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV GAMETYPE "TTT"

COPY entry.sh ${HOMEDIR}/entry.sh
RUN set -x \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
    && { \
		echo '"mountcfg"'; \
		echo '{'; \
		echo '"cstrike"	"'${HOMEDIR}'/css/cstrike"'; \
		echo '"tf"	"'${HOMEDIR}'/tf2/tf"'; \
		echo '}'; \
	   } > "${HOMEDIR}/mount.cfg" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& rm -rf /var/lib/apt/lists/* 
	
ENV SRCDS_PORT=27015
ENV SRCDS_TOKEN=0

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

EXPOSE ${SRCDS_PORT}/udp ${SRCDS_PORT}/tcp

CMD ["bash", "entry.sh"]