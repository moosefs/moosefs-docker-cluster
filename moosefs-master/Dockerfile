FROM ubuntu:14.04

# Install wget, lsb-release and curl
RUN apt-get update && apt-get install -y wget lsb-release curl

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN . /etc/lsb-release && echo "deb http://ppa.moosefs.com/moosefs-3/apt/ubuntu/$DISTRIB_CODENAME $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS master and CGI
RUN apt-get update && apt-get install -y moosefs-master moosefs-cgi moosefs-cgiserv

#Enable CGI Serv
ADD moosefs-cgiserv /etc/default/moosefs-cgiserv

# Expose ports
EXPOSE 9420 9421 9422 9423 9424 9425

# Add and run start script
ADD start.sh /home/start.sh
RUN chown root:root /home/start.sh
RUN chmod 700 /home/start.sh
CMD ["/home/start.sh", "-d"]
