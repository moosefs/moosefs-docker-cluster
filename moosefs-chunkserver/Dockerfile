FROM ubuntu:14.04

RUN apt-get update && apt-get install -y wget lsb-release curl
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN . /etc/lsb-release && echo "deb http://ppa.moosefs.com/moosefs-3/apt/ubuntu/$DISTRIB_CODENAME $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/moosefs.list
RUN apt-get update && apt-get install -y moosefs-chunkserver
EXPOSE 9419
EXPOSE 9420
EXPOSE 9422
ADD start-chunkserver.sh /home/start-chunkserver.sh
RUN chown root:root /home/start-chunkserver.sh
RUN chmod 700 /home/start-chunkserver.sh
CMD ["/home/start-chunkserver.sh", "-d", "172.20.0.2"]
