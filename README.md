# moosefs-docker-cluster

Multiple node MooseFS cluster on Docker. Master with CGI, 5 chunkservers and client node.

Based on [Kai Sasaki's *Lewuathe/docker-hadoop-cluster*](https://github.com/Lewuathe/docker-hadoop-cluster)

## Cluster configuration

- master with CGI [http://172.20.0.2:9425](http://172.20.0.2:9425)
- chunkserver1 **172.20.0.11** with **10 GiB** of storage
- chunkserver2 **172.20.0.12** with **10 GiB** of storage
- chunkserver3 **172.20.0.13** with **10 GiB** of storage
- chunkserver4 **172.20.0.14** with **10 GiB** of storage
- chunkserver5 **172.20.0.15** with **10 GiB** of storage
- client **172.168.20.0.5**

![MooseFS CGI](https://github.com/moosefs/moosefs-docker-cluster/blob/master/images/cgi.png)

## Setup

Install Docker with composer from [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

```
# Clone repository
git clone https://github.com/moosefs/moosefs-docker-cluster

cd moosefs-docker-cluster

docker-compose up
```

Check if instances are running:

```
docker ps
```
Expected output should be similar to:
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

Connect to client node:

```
docker container attach client
```

# Change configuration

If you want to change storage size you can modify chunkserver start script [moosefs-chunkserver/start-chunkserver.sh](https://github.com/moosefs/moosefs-docker-cluster/blob/master/moosefs-chunkserver/start-chunkserver.sh)

Containers configuration is stored in [docker-compose.yml](https://github.com/moosefs/moosefs-docker-cluster/blob/master/docker-compose.yml)

# Docker Hub

| Image name | Pulls | Stars | Build |
|:-----|:-----|:-----|:-----|
| [moosefs/master](https://hub.docker.com/r/moosefs/master/) | [![master](https://img.shields.io/docker/pulls/moosefs/master.svg)](https://hub.docker.com/r/moosefs/master/) | ![master](https://img.shields.io/docker/stars/moosefs/master.svg) | ![](https://img.shields.io/docker/build/moosefs/master.svg) |
| [moosefs/chunkserver](https://hub.docker.com/r/moosefs/chunkserver/)  | [![chunkserver](https://img.shields.io/docker/pulls/moosefs/chunkserver.svg)](https://hub.docker.com/r/moosefs/chunkserver/)    | ![chunkserver](https://img.shields.io/docker/stars/moosefs/chunkserver.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver.svg) |
| [moosefs/client](https://hub.docker.com/r/moosefs/client/) | [![client](https://img.shields.io/docker/pulls/moosefs/client.svg)](https://hub.docker.com/r/moosefs/client/) | ![client](https://img.shields.io/docker/stars/moosefs/client.svg) | ![](https://img.shields.io/docker/build/moosefs/client.svg) |
