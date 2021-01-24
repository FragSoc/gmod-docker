A docker image for running a dedicated server for the game [Garry's Mod](https://store.steampowered.com/app/4000/Garrys_Mod/) with additional gamemodes. This Dockerfile uses [CM2Walki's](https://github.com/CM2Walki/) SteamCMD base image.
# Map collection edits
Below are the optional gamemodes alongside their respoective workshop collections. If you want to include a new map then you need to add it to that gamemode's collection.
```console
TTT - https://steamcommunity.com/sharedfiles/filedetails/?id=2372649360
Prop - https://steamcommunity.com/sharedfiles/filedetails/?id=2372656179
Murder - TBC
Homicide - https://steamcommunity.com/sharedfiles/filedetails/?id=2372659912
```

# How to use this image
## Simple usage (recommended)

Clone this repository locally:<br/>
```console
$ git clone https://github.com/FragSoc/gmod-docker-master.git
```

Create a new directory for the game installation:
```console
$ mkdir -p $(pwd)/garrysmod-data
$ chmod 777 $(pwd)/garrysmod-data # Makes sure the directory is writeable by the unprivileged container user
```

**Make necessary edits to the docker-compose.yml**
**Look at environment variable section below for guidance.**

Run docker-compose up:<br/>
```console
$ docker-compose up
```


**The container will automatically update the game on startup, so if there is a game update just restart the container.**


## Environment Variables
You can overwrite these values within the docker-compose file, below are the defaults: 
```dockerfile
SRCDS_PORT=27015 # The port on which the server communicates on
SRCDS_TOKEN=0 # You will need this to be public
GAMETYPE=TTT # Available options are TTT, Prop, Murder and Homicide
RCON_PWD=changeme # The RCON password for the server
```