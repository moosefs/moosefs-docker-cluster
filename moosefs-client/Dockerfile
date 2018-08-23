FROM ubuntu:14.04

# Install wget, lsb-release and curl
RUN apt-get update && apt-get install -y wget lsb-release curl fuse libfuse2 tree

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN . /etc/lsb-release && echo "deb http://ppa.moosefs.com/moosefs-3/apt/ubuntu/$DISTRIB_CODENAME $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS client
RUN apt-get update && apt-get install -y moosefs-client

# Add and run start script
ADD start-client.sh /home/start-client.sh
RUN chown root:root /home/start-client.sh
RUN chmod 700 /home/start-client.sh

CMD ["/home/start-client.sh", "-bash"]
