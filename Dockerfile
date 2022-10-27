#####################################################################
# Dockerfile that builds a GMOD Gameserver - modified from CS Scrim #
#####################################################################
FROM steamcmd/steamcmd
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ARG UID=999

# Server defaults
ENV GAMETYPE "sandbox"
ENV DEFAULT_MAP "gm_flatgrass"
ENV WORKSHOP_COLLECTION "0"
ENV RCON_PWD "changeme"
ENV SRCDS_TOKEN=0

# Directory layout
ENV CONFIG_DIR "/config"
ENV UPDATE_SCRIPT "${CONFIG_DIR}/${STEAMAPP}_update.txt"
ENV MOUNT_CONFIG "${CONFIG_DIR}/mount.cfg"
ENV HOME /home/gmoduser

# Create user + directories
RUN useradd -m -s /bin/false -u ${UID} -d ${HOME} gmoduser && \
    mkdir -vp ${CONFIG_DIR} /garrysmod /css /tf2 && \
    chown -vR gmoduser:gmoduser \
        ${CONFIG_DIR} /garrysmod /css /tf2

# Install required game content
USER gmoduser
RUN steamcmd +force_install_dir /css \
        +login anonymous \
        +app_update "232330" validate \
        +quit
RUN steamcmd +force_install_dir /tf2 \
        +login anonymous \
        +app_update "232250" validate \
        +quit
RUN steamcmd +@ShutdownOnFailedCommand 1 \
        +@NoPromptForPassword 1 \
        +force_install_dir /garrysmod \
        +login anonymous \
        +app_update 4020 validate \
        +quit

# Copy scripts/config in
COPY --chown=gmoduser entry.sh /entry.sh
COPY --chown=gmoduser mount.cfg /garrysmod/garrysmod/cfg/mount.cfg

# I/O
WORKDIR /garrysmod
EXPOSE 27015/udp
ENTRYPOINT ["bash", "/entry.sh"]
