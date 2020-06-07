# MooseFS Docker Cluster

This is a basic configuration of a multiple nodes MooseFS cluster based on the Debian Buster Docker image. It consists of a master server, a CGI server, 4 chunk servers, and one client. After a successful installation, you will have a fully working MooseFS cluster to play with its amazing features.

# Updates

- All moosefs processes are now correctly handling signals.
- Metadata and data are now persistent and mounted as volumes.
- TEST and PROD moosefs master metadata behavior defined by MFS_ENV variable.
- Specify storage size per chunk server (env: **SIZE**) default not defined. Depends on your local storage free space.
- Specify label per chunk server (env: **LABEL**, default: *empty*).
- Switched to *debian:buster* as a base image.
- Example with 4 chunk servers (labels: M, MB, MB, B).

# Cluster configurations

**File docker-compose.yml**

- master **172.20.0.2**
- CGI [http://localhost:9425](http://localhost:9425) on Linux also [http://172.20.0.3:9425](http://172.20.0.3:9425)
- chunkserver1 **172.20.0.11**, label: **M**
- chunkserver2 **172.20.0.12**, label: **M**,**B**
- chunkserver3 **172.20.0.13**, label: **M**,**B**
- chunkserver4 **172.20.0.14**, label: **B**
- client **172.168.20.0.100**

# Setup

Install Docker with Docker Composer from [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

Clone MooseFS docker config files:

```
git clone https://github.com/moosefs/moosefs-docker-cluster
cd moosefs-docker-cluster
```

Build and run:
```
docker-compose build
docker-compose up
```

On Linux OS run docker-compose as root:
```
sudo -E docker-compose build
sudo -E docker-compose up
```

You can also run docker-compose in detached mode. All running Docker nodes will run in the background, so Docker console output will be invisible.
```
sudo -E docker-compose build
sudo -E docker-compose up -d
```

You can check if instances are running:
```
docker ps
```

You should have 1 master, 4 chunk servers and 1 client running (first configuration). The expected output should be similar to this:

```
CONTAINER ID        IMAGE                                    COMMAND                  CREATED             STATUS              PORTS                     NAMES
76193581d1c4        moosefs-docker-cluster_mfsclient         "mfsmount -f /mnt/mo…"   36 minutes ago      Up 5 seconds        9419-9422/tcp             mfsclient
f69a21cf972c        moosefs-docker-cluster_mfschunkserver2   "chunkserver.sh"         36 minutes ago      Up 6 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver2
5b437ceef0b2        moosefs-docker-cluster_mfschunkserver3   "chunkserver.sh"         36 minutes ago      Up 6 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver3
dede808d4d82        moosefs-docker-cluster_mfschunkserver4   "chunkserver.sh"         38 minutes ago      Up 6 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver4
b4be063af597        moosefs-docker-cluster_mfschunkserver1   "chunkserver.sh"         40 minutes ago      Up 6 seconds        9419-9420/tcp, 9422/tcp   mfschunkserver1
659c3f1fba33        moosefs-docker-cluster_mfscgi            "mfscgiserv -f"          40 minutes ago      Up 6 seconds        0.0.0.0:9425->9425/tcp    mfscgi
b9017fddbd85        moosefs-docker-cluster_mfsmaster         "master.sh"              40 minutes ago      Up 7 seconds        9419-9421/tcp             mfsmaster
```

# Attach/detach to/from container

For example, if you like to **attach** to the client node execute this command:

```
docer exec -it mfslient bash
```

To **detach** from container just press `Ctrl + d` keys.

# MooseFS client

MooseFS filesystem is mounted at `/mnt/moosefs`. If everything is ok you should see this ASCII art:
```
cat /mnt/moosefs/.mooseart
 \_\            /_/
    \_\_    _/_/
        \--/
        /OO\_--____
       (__)        )
        ``\    __  |
           ||-'  `||
           ||     ||
           ""     ""
```

# CGI

The CGI is available here: [http://localhost:9425](http://localhost:9425)
Also on Linux OS CGI container is available at IP address [http://172.20.0.3:9425](http://172.20.0.3:9425) (be aware of a local 172.20.0.* network).

![MooseFS CGI](https://github.com/moosefs/moosefs-docker-cluster/raw/master/images/cgi.png)

# Persistence

Your MooseFS Docker cluster is persistent. It means all files you created in the /mnt/moosefs folder will remain there even after turning containers off.
All data and metadata files are stored in the host `./data` directory.
# Docker Hub

| Image name | Pulls | Stars | Build |
|:-----|:-----|:-----|:-----|
| [moosefs/master](https://hub.docker.com/r/moosefs/master/) | [![master](https://img.shields.io/docker/pulls/moosefs/master.svg)](https://hub.docker.com/r/moosefs/master/) | ![master](https://img.shields.io/docker/stars/moosefs/master.svg) | ![](https://img.shields.io/docker/build/moosefs/master.svg) |
| [moosefs/client](https://hub.docker.com/r/moosefs/client/) | [![client](https://img.shields.io/docker/pulls/moosefs/client.svg)](https://hub.docker.com/r/moosefs/client/) | ![client](https://img.shields.io/docker/stars/moosefs/client.svg) | ![](https://img.shields.io/docker/build/moosefs/client.svg) |
| [moosefs/chunkserver](https://hub.docker.com/r/moosefs/chunkserver/)  | [![chunkserver](https://img.shields.io/docker/pulls/moosefs/chunkserver.svg)](https://hub.docker.com/r/moosefs/chunkserver/)    | ![chunkserver](https://img.shields.io/docker/stars/moosefs/chunkserver.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver.svg) |
| [moosefs/chunkserver-client](https://hub.docker.com/r/moosefs/chunkserver-client/)  | [![chunkserver-client](https://img.shields.io/docker/pulls/moosefs/chunkserver-client.svg)](https://hub.docker.com/r/moosefs/chunkserver-client/)    | ![chunkserver-client](https://img.shields.io/docker/stars/moosefs/chunkserver-client.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver-client.svg) |

Scripts are based on [Kai Sasaki's *Lewuathe/docker-hadoop-cluster*](https://github.com/Lewuathe/docker-hadoop-cluster). Thank you Kai!
