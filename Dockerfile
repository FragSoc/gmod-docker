#####################################################################
# Dockerfile that builds a GMOD Gameserver - modified from CS Scrim #
#####################################################################
FROM cm2network/steamcmd:root
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ARG UID=999

# Server defaults
ENV GAMETYPE "sandbox"
ENV DEFAULT_MAP "gm_flatgrass"
ENV WORKSHOP_COLLECTION "0"
ENV RCON_PWD "changeme"
ENV STEAMAPP "garrysmod"
ENV SRCDS_TOKEN=0

# Directory layout
ENV STEAMAPPDIR "/${STEAMAPP}"
ENV CONFIG_DIR "/config"
ENV UPDATE_SCRIPT "${CONFIG_DIR}/${STEAMAPP}_update.txt"
ENV MOUNT_CONFIG "${CONFIG_DIR}/mount.cfg"

# Create user, directories and required game content
RUN useradd -s /bin/false -u ${UID} gmoduser && \
    mkdir -p ${CONFIG_DIR} ${STEAMAPPDIR} /css /tf2 && \
    steamcmd +login anonymous \
        +force_install_dir /css \
        +app_update "232330" validate \
        +force_install_dir /tf2 \
        +app_update "232250" validate \
        +quit && \
    chown -R gmoduser:gmoduser \
        ${CONFIG_DIR} ${STEAMAPPDIR} /css /tf2

# Copy scripts/config in
COPY --chown=gmoduser entry.sh /entry.sh
COPY --chown=gmoduser mount.cfg ${MOUNT_CONFIG}
COPY --chown=gmoduser garrysmod_update.txt ${UPDATE_SCRIPT}

# I/O
USER gmoduser
VOLUME ${STEAMAPPDIR}
WORKDIR ${STEAMAPPDIR}
EXPOSE 27015/udp
ENTRYPOINT ["bash", "/entry.sh"]
