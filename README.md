# MooseFS Docker Cluster

This is a sample configuration of a multiple node MooseFS cluster on Docker using Ubuntu 14.04 LTS. It consists of a master server with a management GUI, 5 chunkservers and one client machine. After a successful installation you have a fully working MooseFS cluster to play with its amazing features.

## Cluster configurations

**File docker-compose.yml**

- master with management GUI [http://172.20.0.2:9425](http://172.20.0.2:9425)
- chunkserver1 **172.20.0.11** with **10 GiB** of storage
- chunkserver2 **172.20.0.12** with **10 GiB** of storage
- chunkserver3 **172.20.0.13** with **10 GiB** of storage
- chunkserver4 **172.20.0.14** with **10 GiB** of storage
- chunkserver5 **172.20.0.15** with **10 GiB** of storage
- client **172.168.20.0.5**

**File docker-compose-chunkserver-client.yml**

- master with CGI [http://172.20.0.2:9425](http://172.20.0.2:9425)
- chunkserver1 **172.20.0.11** with **10 GiB** of storage and client (mount point: `/mnt/mfs`)
- chunkserver2 **172.20.0.12** with **10 GiB** of storage and client (mount point: `/mnt/mfs`)
- chunkserver3 **172.20.0.13** with **10 GiB** of storage and client (mount point: `/mnt/mfs`)
- chunkserver4 **172.20.0.14** with **10 GiB** of storage and client (mount point: `/mnt/mfs`)
- chunkserver5 **172.20.0.15** with **10 GiB** of storage and client (mount point: `/mnt/mfs`)

![MooseFS CGI](https://github.com/moosefs/moosefs-docker-cluster/raw/master/images/cgi.png)

## Setup

Install Docker with composer from [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

Clone MooseFS docker config files:

```
git clone https://github.com/moosefs/moosefs-docker-cluster
```

### Start MooseFS cluster:

Go to repo directory:

```
cd moosefs-docker-cluster
```

Build and run in background:

```
docker-compose build
docker-compose up -d
```

"-d" is for running Docker nodes in background, so Docker console output is invisible.

Check if instances are running with:

```
docker ps
```
You should have 1 master, 5 chunkservers and 1 client running. Expected output should be similar to:
```
CONTAINER ID        IMAGE                               COMMAND                  CREATED             STATUS              PORTS                     NAMES
2fe620447b37        dockermoosefscluster_client         "/home/start-clien..."   5 minutes ago       Up 5 minutes                                  client
1951d867c078        dockermoosefscluster_chunkserver5   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver5
204c115cd8ad        dockermoosefscluster_chunkserver2   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver2
48343721de4f        dockermoosefscluster_chunkserver4   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver4
30ca217fa862        dockermoosefscluster_master         "/home/start.sh -d"      5 minutes ago       Up 5 minutes        9420-9425/tcp             master
28e2a64d0fb9        dockermoosefscluster_chunkserver1   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver1
c83c70580795        dockermoosefscluster_chunkserver3   "/home/start-chunk..."   5 minutes ago       Up 5 minutes        9419-9420/tcp, 9422/tcp   chunkserver3
```

You can **attach** to the client node (press "Enter" twice):

```
docker container attach mfsclient  #press the "Enter" key twice
```

To **detach** from container use the escape sequence `Ctrl + p`, `Ctrl + q`.

Now MooseFS filesystem is mounted as `/mnt/mfs`. If everything is ok you should see our welcome message with:
```
cd /mnt/mfs

cat welcome_to_moosefs.txt
```
The management GUI is available here: [http://172.20.0.2:9425](http://172.20.0.2:9425) (be aware of a local 172.20.0.* network).

To stop all (all means ALL, not just MooseFS's) your Docker containers:
```
docker stop $(docker ps -aq)
```

Your MooseFS Docker cluster is persistent. It means all files you created in the /mnt/mfs folder will remain there even after turning containers off.  

### Stop the cluster
`docker-compose stop`

### Restart the stopped cluster
`docker-compose start`

### Remove containers
`docker-compose rm -f`

# Change configuration

If you want to change storage size modify the chunkserver start script [moosefs-chunkserver/start-chunkserver.sh](https://github.com/moosefs/moosefs-docker-cluster/blob/master/moosefs-chunkserver/start-chunkserver.sh)

Default configuration is stored in [docker-compose.yml](https://github.com/moosefs/moosefs-docker-cluster/blob/master/docker-compose.yml)

**Other configurations**

If you want to use other than default compose yml file (`docker-compose.yml`) use following commands:

```
docker-compose -f docker-compose-chunkserver-client.yml build
docker-compose -f docker-compose-chunkserver-client.yml up -d
```

When using `docker-compose-chunkserver-client.yml` you will have 5 chunkserver/client machines so you can  attach to mfschunkserverclient1, ...,  mfschunkserverclient5.

# Docker Hub

| Image name | Pulls | Stars | Build |
|:-----|:-----|:-----|:-----|
| [moosefs/master](https://hub.docker.com/r/moosefs/master/) | [![master](https://img.shields.io/docker/pulls/moosefs/master.svg)](https://hub.docker.com/r/moosefs/master/) | ![master](https://img.shields.io/docker/stars/moosefs/master.svg) | ![](https://img.shields.io/docker/build/moosefs/master.svg) |
| [moosefs/client](https://hub.docker.com/r/moosefs/client/) | [![client](https://img.shields.io/docker/pulls/moosefs/client.svg)](https://hub.docker.com/r/moosefs/client/) | ![client](https://img.shields.io/docker/stars/moosefs/client.svg) | ![](https://img.shields.io/docker/build/moosefs/client.svg) |
| [moosefs/chunkserver](https://hub.docker.com/r/moosefs/chunkserver/)  | [![chunkserver](https://img.shields.io/docker/pulls/moosefs/chunkserver.svg)](https://hub.docker.com/r/moosefs/chunkserver/)    | ![chunkserver](https://img.shields.io/docker/stars/moosefs/chunkserver.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver.svg) |
| [moosefs/chunkserver-client](https://hub.docker.com/r/moosefs/chunkserver-client/)  | [![chunkserver-client](https://img.shields.io/docker/pulls/moosefs/chunkserver-client.svg)](https://hub.docker.com/r/moosefs/chunkserver-client/)    | ![chunkserver-client](https://img.shields.io/docker/stars/moosefs/chunkserver-client.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver-client.svg) |

Scripts are based on [Kai Sasaki's *Lewuathe/docker-hadoop-cluster*](https://github.com/Lewuathe/docker-hadoop-cluster). Thank you Kai!
