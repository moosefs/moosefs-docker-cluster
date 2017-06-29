# moosefs-docker-cluster

This is a sample configuration of a multiple node MooseFS cluster on Docker using Ubuntu 14.04 LTS. It consists of a master server with a management GUI, 5 chunkservers and one client machine. After a successful installation you have a fully working MooseFS cluster to play with its amazing features.

## Cluster configuration

- master with management GUI [http://172.20.0.2:9425](http://172.20.0.2:9425)
- chunkserver1 **172.20.0.11** with **10 GiB** of storage
- chunkserver2 **172.20.0.12** with **10 GiB** of storage
- chunkserver3 **172.20.0.13** with **10 GiB** of storage
- chunkserver4 **172.20.0.14** with **10 GiB** of storage
- chunkserver5 **172.20.0.15** with **10 GiB** of storage
- client **172.168.20.0.5**

![MooseFS CGI](https://github.com/moosefs/moosefs-docker-cluster/blob/master/images/cgi.png)

## Setup

Install Docker with composer from [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

Clone MooseFS docker config files:

```
git clone https://github.com/moosefs/moosefs-docker-cluster
```

Start MooseFS servers:
```
cd moosefs-docker-cluster

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

You can attach to the client node (press "Enter" twice):

```
docker container attach client  #press "Enter" key twice
```

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

# Change configuration

If you want to change storage size modify the chunkserver start script [moosefs-chunkserver/start-chunkserver.sh](https://github.com/moosefs/moosefs-docker-cluster/blob/master/moosefs-chunkserver/start-chunkserver.sh)

Containers configuration is stored in [docker-compose.yml](https://github.com/moosefs/moosefs-docker-cluster/blob/master/docker-compose.yml)

# Docker Hub

| Image name | Pulls | Stars | Build |
|:-----|:-----|:-----|:-----|
| [moosefs/master](https://hub.docker.com/r/moosefs/master/) | [![master](https://img.shields.io/docker/pulls/moosefs/master.svg)](https://hub.docker.com/r/moosefs/master/) | ![master](https://img.shields.io/docker/stars/moosefs/master.svg) | ![](https://img.shields.io/docker/build/moosefs/master.svg) |
| [moosefs/chunkserver](https://hub.docker.com/r/moosefs/chunkserver/)  | [![chunkserver](https://img.shields.io/docker/pulls/moosefs/chunkserver.svg)](https://hub.docker.com/r/moosefs/chunkserver/)    | ![chunkserver](https://img.shields.io/docker/stars/moosefs/chunkserver.svg)  | ![](https://img.shields.io/docker/build/moosefs/chunkserver.svg) |
| [moosefs/client](https://hub.docker.com/r/moosefs/client/) | [![client](https://img.shields.io/docker/pulls/moosefs/client.svg)](https://hub.docker.com/r/moosefs/client/) | ![client](https://img.shields.io/docker/stars/moosefs/client.svg) | ![](https://img.shields.io/docker/build/moosefs/client.svg) |

Scripts are based on [Kai Sasaki's *Lewuathe/docker-hadoop-cluster*](https://github.com/Lewuathe/docker-hadoop-cluster). Thank you Kai!
