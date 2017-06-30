FROM ubuntu:14.04

# Install wget, lsb-release and curl
RUN apt-get update && apt-get install -y wget lsb-release curl

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN . /etc/lsb-release && echo "deb http://ppa.moosefs.com/moosefs-3/apt/ubuntu/$DISTRIB_CODENAME $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS chunkserver
RUN apt-get update && apt-get install -y moosefs-chunkserver

# Expose ports
EXPOSE 9419 9420 9422

# Add and run start script
ADD start-chunkserver.sh /home/start-chunkserver.sh
RUN chown root:root /home/start-chunkserver.sh
RUN chmod 700 /home/start-chunkserver.sh

CMD ["/home/start-chunkserver.sh", "-d"]
