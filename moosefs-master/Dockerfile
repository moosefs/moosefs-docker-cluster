FROM debian:buster

# Install wget and gnupg2
RUN apt-get update && apt-get install -y wget gnupg2

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key 2>/dev/null | apt-key add - 2>/dev/null
RUN echo "deb http://ppa.moosefs.com/3.0.115/apt/debian/buster buster main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS master
RUN apt-get update && apt-get install -y moosefs-master

# Expose ports master ports
EXPOSE 9419 9420 9421

# Add and run start script
ADD master.sh /usr/sbin/master.sh
RUN chown root:root /usr/sbin/master.sh ; chmod 700 /usr/sbin/master.sh

CMD ["master.sh"]
