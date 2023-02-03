FROM debian:buster

# Install wget and gnupg2
RUN apt-get update && apt-get install -y wget gnupg2 gettext-base

# Add key
RUN wget -O - http://ppa.moosefs.com/moosefs.key 2>/dev/null | apt-key add - 2>/dev/null
RUN echo "deb http://ppa.moosefs.com/3.0.117/apt/debian/buster buster main" > /etc/apt/sources.list.d/moosefs.list

# Install MooseFS metalogger
RUN apt-get update && apt-get install -y moosefs-metalogger

# Add and run start script
ADD metalogger.sh /usr/sbin/metalogger.sh
RUN chown root:root /usr/sbin/metalogger.sh ; chmod 700 /usr/sbin/metalogger.sh

CMD ["metalogger.sh"]
