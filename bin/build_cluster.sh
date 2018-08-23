#!/bin/bash

PROGNAME=$(basename $0)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_usage() {
  echo "Usage: $0 [launch|destroy]"
  echo ""
  echo "    launch  : Launch moosefs cluster on docker"
  echo "    destroy : Remove moosefs cluster on docker"
  echo "    build   : Build docker images with local moosefs binary"
  echo ""
  echo "    Options:"
  echo "        -h,  --help      : Print usage"
  echo "        -s, --chunkservers : Specify the number of chunkservers"
  echo ""
}

if [ $# -eq 0 ]; then
  print_usage
fi

DATANODE_NUM=3
CLUSTER_NAME=default_cluster

for OPT in "$@"
do
    case "$OPT" in
        '-h'|'--help' )
            print_usage
            exit 1
            ;;
        '-s'|'--chunkservers' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "$PROGNAME: option requires an argument -- $1" 1>&2
                exit 1
            fi
            DATANODE_NUM="$2"
            shift 2
            ;;
        '-c'|'--cluster' )
            CLUSTER_NAME="$2"
            shift 2
            ;;
        -*)
            echo "$PROGNAME: illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
            exit 1
            ;;
        *)
            ;;
    esac
done

launch_cluster() {
  if ! docker network inspect moosefs-network > /dev/null ; then
    echo "Creating moosefs-network"
    docker network create --driver bridge moosefs-network
  fi
  echo "Launching master server"
  docker run -d -p 9870:9870 -p 8088:8088 -p 19888:19888 -p 8188:8188 --net moosefs-network --name master -h master karolmajek/moosefs-master:latest
  echo "Launching chunkservers"
  for i in `seq 1 $DATANODE_NUM`; do
    docker run -d -p 990${i}:9864 -p 804${i}:8042 --name chunkserver${i} -h chunkserver${i} --net moosefs-network karolmajek/moosefs-chunkserver:latest
  done
}

destroy_cluster() {
  docker kill master; docker rm master
  for i in `seq 1 $DATANODE_NUM`; do
    docker kill chunkserver${i}; docker rm chunkserver${i}
  done
  docker network rm moosefs-network
}

build_images() {
  # cd $DIR/../moosefs-base
  # docker build -f Dockerfile-local -t karolmajek/moosefs-base:latest .
  cd $DIR/../moosefs-master
  docker build -t karolmajek/moosefs-master:latest .
  cd $DIR/../moosefs-chunkserver
  docker build -t karolmajek/moosefs-chunkserver:latest .
}

case $1 in
    launch) launch_cluster
        ;;
    destroy) destroy_cluster
        ;;
    build) build_images
        ;;
esac

exit 0
