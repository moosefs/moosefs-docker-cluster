FROM debian:buster

# Install wget and gnupg2
RUN apt-get update && apt-get install -y wget gnupg2 python3

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key 2>/dev/null | apt-key add - 2>/dev/null
RUN echo "deb http://ppa.moosefs.com/3.0.117/apt/debian/buster buster main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS master
RUN apt-get update && apt-get install -y moosefs-cgi moosefs-cgiserv moosefs-cli

# Expose ports master ports
EXPOSE 9425

# Add start script
ADD cgiserver.sh /usr/sbin/cgiserver.sh
RUN chown root:root /usr/sbin/cgiserver.sh ; chmod 700 /usr/sbin/cgiserver.sh

CMD ["cgiserver.sh"]
