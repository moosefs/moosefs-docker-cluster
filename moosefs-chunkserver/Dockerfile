FROM debian:stretch

# Install wget, lsb-release and curl
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget lsb-release curl  net-tools gnupg2 systemd

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN echo "deb http://ppa.moosefs.com/moosefs-3/apt/$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)/$(lsb_release -sc) $(lsb_release -sc) main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS chunkserver
RUN apt-get update && apt-get install -y moosefs-chunkserver

# Expose ports
EXPOSE 9419 9420 9422

# Add and run start script
ADD start-chunkserver.sh /home/start-chunkserver.sh
RUN chown root:root /home/start-chunkserver.sh
RUN chmod 700 /home/start-chunkserver.sh

CMD ["/home/start-chunkserver.sh", "-d"]
