FROM debian:buster

# Install libraries
RUN apt-get update && apt-get install -y wget fuse3 libfuse3-3 gnupg2 python3

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key 2>/dev/null | apt-key add - 2>/dev/null
RUN echo "deb http://ppa.moosefs.com/3.0.117/apt/debian/buster buster main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS client and cli
RUN apt-get update && apt-get install -y moosefs-client moosefs-cli

# Add start script
ADD mount.sh /usr/sbin/mount.sh
RUN chown root:root /usr/sbin/mount.sh ; chmod 700 /usr/sbin/mount.sh ; mkdir -p /mnt/moosefs

CMD ["mount.sh"]
