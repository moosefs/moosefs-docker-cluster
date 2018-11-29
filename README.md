# MooseFS Docker Cluster

This is a sample configuration of a multiple node MooseFS cluster on Docker using Ubuntu 14.04 LTS. It consists of a master server with a CGI, 5 chunkservers and one client machine. After a successful installation you have a fully working MooseFS cluster to play with its amazing features.

# Updates

New features:
- specify storage size per chunkserver (env: **SIZE**, default: 10)
- specify label per chunkserver (env: **LABEL**, default: *empty*)
- switched to *debian:stretch* as base image
- example with 4 chunkservers (labels: M, MB, MB, B)
- MooseFS disks are now mounted as volumes

# Cluster configurations

In this repository you will find 2 sample configurations which you can run to try MooseFS.

## 4 Chunkservers + Client

Build and run in background:

```
docker-compose build
docker-compose up -d
```

**File docker-compose.yml**

- master with CGI [http://172.20.0.2:9425](http://172.20.0.2:9425)
- chunkserver1 **172.20.0.11**, **10 GiB** storage, label: **M**
- chunkserver2 **172.20.0.12**, **10 GiB** storage, label: **M**,**B**
- chunkserver3 **172.20.0.13**, **10 GiB** storage, label: **M**,**B**
- chunkserver4 **172.20.0.14**, **10 GiB** storage, label: **B**
- client **172.168.20.0.5**

## 4 Chunkservers + 4 Clients

Build and run in background:

```
docker-compose -f docker-compose-chunkserver-client.yml build
docker-compose -f docker-compose-chunkserver-client.yml up -d
```

**File docker-compose-chunkserver-client.yml**

- master with CGI [http://172.20.0.2:9425](http://172.20.0.2:9425)
- chunkserver1 **172.20.0.11**, **10 GiB** storage, label: **M** (mount point: `/mnt/moosefs`)
- chunkserver2 **172.20.0.12**, **10 GiB** storage, label: **M,B** (mount point: `/mnt/moosefs`)
- chunkserver3 **172.20.0.13**, **10 GiB** storage, label: **M,B** (mount point: `/mnt/moosefs`)
- chunkserver4 **172.20.0.14**, **10 GiB** storage, label: **B** (mount point: `/mnt/moosefs`)

# Setup

Install Docker with Docker Composer from [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

Clone MooseFS docker config files:

```
git clone https://github.com/moosefs/moosefs-docker-cluster
cd moosefs-docker-cluster
```

Build and run in background:

```
docker-compose build
docker-compose up -d
```

or

```
docker-compose -f docker-compose-chunkserver-client.yml build
docker-compose -f docker-compose-chunkserver-client.yml up -d
```

"-d" is detached - running Docker nodes in background, so Docker console output is invisible.

You can check if instances are running:

```
docker ps
```

You should have 1 master, 4 chunkservers and 1 client running (first configuration). Expected output should be similar to:

```
CONTAINER ID        IMAGE                               COMMAND                  CREATED             STATUS              PORTS                     NAMES
2fe620447b37        dockermoosefscluster_client         "/home/start-clien..."   5 minutes ago       Up 5 minutes                                  client
204c115cd8ad        dockermoosefscluster_chunkserver2   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver2
48343721de4f        dockermoosefscluster_chunkserver4   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver4
30ca217fa862        dockermoosefscluster_master         "/home/start.sh -d"      5 minutes ago       Up 5 minutes        9420-9425/tcp             master
28e2a64d0fb9        dockermoosefscluster_chunkserver1   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver1
c83c70580795        dockermoosefscluster_chunkserver3   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver3
```

# Attach/detach to/from container

You can **attach** to the client node (press "Enter" twice):

```
docker container attach mfsclient
```

To **detach** from container use the escape sequence `Ctrl + p`, `Ctrl + q`.

Now MooseFS filesystem is mounted as `/mnt/moosefs`. If everything is ok you should see our welcome message with:
```
cd /mnt/moosefs

cat welcome_to_moosefs.txt
```

# CGI

The CGI is available here: [http://172.20.0.2:9425](http://172.20.0.2:9425) (be aware of a local 172.20.0.* network).

![MooseFS CGI](https://github.com/moosefs/moosefs-docker-cluster/raw/master/images/cgi.png)

# Persistence

Your MooseFS Docker cluster is persistent. It means all files you created in the /mnt/moosefs folder will remain there even after turning containers off.
MooseFS disks are now mounted in host `./data` directory.

# Warning

Chunkservers are paired with Master server, so if you destroy the machine with master server you will not be able to access your data. Data will still be there in volumes (`./data` directory) but chunkservers will not want to connect to the new Master server.

# Docker Hub

| Image name | Pulls | Stars | Build |
|:-----|:-----|:-----|:-----|
| [moosefs/master](https://hub.docker.com/r/moosefs/master/) | [![master](https://img.shields.io/docker/pulls/moosefs/master.svg)](https://hub.docker.com/r/moosefs/master/) | ![master](https://img.shields.io/docker/stars/moosefs/master.svg) | ![](https://img.shields.io/docker/build/moosefs/master.svg) |
| [moosefs/client](https://hub.docker.com/r/moosefs/client/) | [![client](https://img.shields.io/docker/pulls/moosefs/client.svg)](https://hub.docker.com/r/moosefs/client/) | ![client](https://img.shields.io/docker/stars/moosefs/client.svg) | ![](https://img.shields.io/docker/build/moosefs/client.svg) |
| [moosefs/chunkserver](https://hub.docker.com/r/moosefs/chunkserver/)  | [![chunkserver](https://img.shields.io/docker/pulls/moosefs/chunkserver.svg)](https://hub.docker.com/r/moosefs/chunkserver/)    | ![chunkserver](https://img.shields.io/docker/stars/moosefs/chunkserver.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver.svg) |
| [moosefs/chunkserver-client](https://hub.docker.com/r/moosefs/chunkserver-client/)  | [![chunkserver-client](https://img.shields.io/docker/pulls/moosefs/chunkserver-client.svg)](https://hub.docker.com/r/moosefs/chunkserver-client/)    | ![chunkserver-client](https://img.shields.io/docker/stars/moosefs/chunkserver-client.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver-client.svg) |

Scripts are based on [Kai Sasaki's *Lewuathe/docker-hadoop-cluster*](https://github.com/Lewuathe/docker-hadoop-cluster). Thank you Kai!
