FROM ubuntu:14.04

RUN apt-get update && apt-get install -y wget lsb-release curl
RUN wget -O - http://ppa.moosefs.com/moosefs.key | apt-key add -
RUN . /etc/lsb-release && echo "deb http://ppa.moosefs.com/moosefs-3/apt/ubuntu/$DISTRIB_CODENAME $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/moosefs.list
RUN apt-get update && apt-get install -y moosefs-master moosefs-cgi moosefs-cgiserv moosefs-cli
ADD moosefs-cgiserv /etc/default/moosefs-cgiserv
EXPOSE 9420 9421 9422 9423 9424 9425
ADD start.sh /home/start.sh
RUN chown root:root /home/start.sh
RUN chmod 700 /home/start.sh
CMD ["/home/start.sh", "-d"]
# CMD cp /etc/mfs/mfsmaster.cfg.sample /etc/mfs/mfsmaster.cfg
# CMD cp /etc/mfs/mfsexports.cfg.sample /etc/mfs/mfsexports.cfg
# # RUN sed -i '/MFSCHUNKSERVER_ENABLE=false/c\MFSCHUNKSERVER_ENABLE=true' /etc/default/moosefs-chunkserver
# CMD mfsmaster start -a
# CMD service moosefs-cgiserv start
# CMD bash
