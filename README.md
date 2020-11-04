# MooseFS Docker Cluster

This is a basic configuration of a multiple-node MooseFS cluster based on the Debian Buster Docker image. It consists of a Master Server, a CGI Monitoring Interface Server, 4 Chunkservers, and one Client. After a successful installation, you will have a fully working MooseFS cluster to play with its amazing features.

# Updates

- All MooseFS processes are now correctly handling signals.
- Metadata and data are now persistent and mounted as volumes.
- TEST and PROD moosefs master metadata behavior defined by `MFS_ENV` variable.
- Specify storage size per chunk server (env: `SIZE`) default not defined. Depends on your local storage free space.
- Specify label per chunk server (env: `LABEL`, default: *empty*).
- Switched to *debian:buster* as a base image.
- Example with 4 chunk servers (labels: M, MB, MB, B).

# Cluster configurations

**File docker-compose.yml**

- Master Server: `172.20.0.2`
- CGI Monitoring Interface: [http://localhost:9425](http://localhost:9425), on Linux also [http://172.20.0.3:9425](http://172.20.0.3:9425)
- Metalogger: `172.20.0.4`
- Chunkserver 1: `172.20.0.11`, labels: `M`
- Chunkserver 2: `172.20.0.12`, labels: `M, B`
- Chunkserver 3: `172.20.0.13`, labels: `M, B`
- Chunkserver 4: `172.20.0.14`, labels: `B`
- Client: `172.168.20.0.100`

# Setup

Install Docker with Docker Composer from [https://docs.docker.com/compose/install](https://docs.docker.com/compose/install)

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

On Linux OS run `docker-compose` as root:

```
sudo -E docker-compose build
sudo -E docker-compose up
```

You can also run `docker-compose` in detached mode. All running Docker nodes will run in the background, so Docker console output will be invisible.

```
sudo -E docker-compose build
sudo -E docker-compose up -d
```

You can check if instances are running:

```
docker ps
```

You should have 1 Master Server, 1 Metalogger, 4 Chunkservers and 1 Client running (first configuration). The expected output should be similar to the following:

```
CONTAINER ID        IMAGE                                  COMMAND                  CREATED             STATUS              PORTS                    NAMES
abf5910b53bc        moosefsdockercluster_mfsclient         "mfsmount -f /mnt/mo…"   7 minutes ago       Up 7 minutes                                 mfsclient
7a1152cc31f3        moosefsdockercluster_mfschunkserver3   "chunkserver.sh"         7 minutes ago       Up 7 minutes        9422/tcp                 mfschunkserver3
b8c2cd770187        moosefsdockercluster_mfschunkserver2   "chunkserver.sh"         7 minutes ago       Up 7 minutes        9422/tcp                 mfschunkserver2
100f20683b3a        moosefsdockercluster_mfschunkserver1   "chunkserver.sh"         7 minutes ago       Up 7 minutes        9422/tcp                 mfschunkserver1
68ffb70ab361        moosefsdockercluster_mfschunkserver4   "chunkserver.sh"         7 minutes ago       Up 7 minutes        9422/tcp                 mfschunkserver4
82a2c3bd831d        moosefsdockercluster_mfsmetalogger     "metalogger.sh"          7 minutes ago       Up 7 minutes                                 mfsmetalogger
05736e4bdd3c        moosefsdockercluster_mfscgi            "mfscgiserv -f"          7 minutes ago       Up 7 minutes        0.0.0.0:9425->9425/tcp   mfscgi
e83a1fb062a1        moosefsdockercluster_mfsmaster         "master.sh"              7 minutes ago       Up 7 minutes        9419-9421/tcp            mfsmaster
```

# Attach / detach to / from container

For example, if you like to **attach** to the client node execute this command:

```
docker exec -it mfsclient bash
```

To **detach** from container, just press `Ctrl + D` keys combination.

# MooseFS Client

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

# MooseFS CGI Monitoring Interface

The MooseFS CGI Monitoring Interface is available here: [http://localhost:9425](http://localhost:9425).

Also on Linux, CGI Server container is available at the IP address: [http://172.20.0.3:9425](http://172.20.0.3:9425) (be aware of a local `172.20.0.x` network).

![MooseFS CGI](https://github.com/moosefs/moosefs-docker-cluster/raw/master/images/cgi.png)

# Persistence

Your MooseFS Docker cluster is persistent. It means all files you created in the `/mnt/moosefs` folder will remain there even after turning containers off.
All data and metadata files are stored in the host `./data` directory.
# Docker Hub

| Image name | Image size | Pulls | Stars | Build |
|:-----|:-----|:-----|:-----|:-----|
| [moosefs/master](https://hub.docker.com/r/moosefs/master/) | ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/moosefs/master?sort=date) | [![master](https://img.shields.io/docker/pulls/moosefs/master)](https://hub.docker.com/r/moosefs/master/) | ![master](https://img.shields.io/docker/stars/moosefs/master) | ![master](https://img.shields.io/docker/build/moosefs/master) |
| [moosefs/chunkserver](https://hub.docker.com/r/moosefs/chunkserver/) | ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/moosefs/chunkserver?sort=date) | [![chunkserver](https://img.shields.io/docker/pulls/moosefs/chunkserver)](https://hub.docker.com/r/moosefs/chunkserver/) | ![chunkserver](https://img.shields.io/docker/stars/moosefs/chunkserver) | ![chunkserver](https://img.shields.io/docker/build/moosefs/chunkserver) |
| [moosefs/client](https://hub.docker.com/r/moosefs/client/) | ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/moosefs/client?sort=date) | [![client](https://img.shields.io/docker/pulls/moosefs/client)](https://hub.docker.com/r/moosefs/client/) | ![client](https://img.shields.io/docker/stars/moosefs/client) | ![client](https://img.shields.io/docker/build/moosefs/client) |
| [moosefs/metalogger](https://hub.docker.com/r/moosefs/metalogger/) | ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/moosefs/metalogger?sort=date) | [![metalogger](https://img.shields.io/docker/pulls/moosefs/metalogger)](https://hub.docker.com/r/moosefs/cgi/)    | ![metalogger](https://img.shields.io/docker/stars/moosefs/metalogger)  | ![metalogger](https://img.shields.io/docker/build/moosefs/metalogger) |
| [moosefs/cgi](https://hub.docker.com/r/moosefs/cgi/) | ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/moosefs/cgi?sort=date) | [![cgi](https://img.shields.io/docker/pulls/moosefs/cgi)](https://hub.docker.com/r/moosefs/cgi/) | ![cgi](https://img.shields.io/docker/stars/moosefs/cgi)  | ![cgi](https://img.shields.io/docker/build/moosefs/cgi) |