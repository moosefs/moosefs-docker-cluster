FROM debian:stretch

# Install wget, lsb-release, curl, fuse and tree
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget lsb-release curl fuse libfuse2  net-tools gnupg2 systemd tree

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN echo "deb http://ppa.moosefs.com/moosefs-3/apt/$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)/$(lsb_release -sc) $(lsb_release -sc) main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS chunkserver and client
RUN apt-get update && apt-get install -y moosefs-chunkserver moosefs-client

# Expose ports
EXPOSE 9419 9420 9422

# Add and run start script
ADD start-chunkserver-client.sh /home/start-chunkserver-client.sh
RUN chown root:root /home/start-chunkserver-client.sh
RUN chmod 700 /home/start-chunkserver-client.sh

CMD ["/home/start-chunkserver-client.sh", "-bash"]
