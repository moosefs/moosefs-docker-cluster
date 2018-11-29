FROM debian:stretch

# Install wget, lsb-release, curl, fuse and tree
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget lsb-release curl fuse libfuse2  net-tools gnupg2 systemd tree

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN echo "deb http://ppa.moosefs.com/moosefs-3/apt/$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)/$(lsb_release -sc) $(lsb_release -sc) main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS client
RUN apt-get update && apt-get install -y moosefs-client

# Add and run start script
ADD start-client.sh /home/start-client.sh
RUN chown root:root /home/start-client.sh
RUN chmod 700 /home/start-client.sh

CMD ["/home/start-client.sh", "-bash"]
