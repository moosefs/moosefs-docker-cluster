FROM debian:buster

# Install wget, lsb-release and curl
RUN apt-get update && apt-get install -y wget gnupg2 gettext-base

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key 2>/dev/null | apt-key add - 2>/dev/null
RUN echo "deb http://ppa.moosefs.com/3.0.115/apt/debian/buster buster main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS chunkserver
RUN apt-get update && apt-get install -y moosefs-chunkserver

# Expose ports
EXPOSE 9422

# Add start script
ADD chunkserver.sh /usr/sbin/chunkserver.sh
RUN chown root:root /usr/sbin/chunkserver.sh ; chmod 700 /usr/sbin/chunkserver.sh ; mkdir -p /mnt/hdd0

CMD ["chunkserver.sh"]
