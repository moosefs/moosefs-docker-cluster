FROM debian:stretch

# Install wget, lsb-release and curl
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget lsb-release curl net-tools gnupg2 systemd python

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN echo "deb http://ppa.moosefs.com/moosefs-3/apt/$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)/$(lsb_release -sc) $(lsb_release -sc) main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS master and CGI
RUN apt-get update && apt-get install -y moosefs-master moosefs-cgi moosefs-cgiserv

#Enable CGI server autostart
RUN systemctl enable moosefs-cgiserv

#Enable master server autostart
RUN systemctl enable moosefs-master

# Expose ports
EXPOSE 9420 9421 9422 9423 9424 9425

# Add and run start script
ADD start.sh /home/start.sh
RUN chown root:root /home/start.sh
RUN chmod 700 /home/start.sh
CMD ["/home/start.sh", "-d"]
