ARG MFS_TAG="v4.57.6"

# Build MooseFS chunkserver from source on Debian 12 Bookworm container
# mfsbuilder image is based on Debian 12
FROM ghcr.io/moosefs/mfsbuilder:latest AS mfsbuilder
WORKDIR /moosefs
ARG MFS_TAG
RUN git clone --depth 1 --branch ${MFS_TAG} https://github.com/moosefs/moosefs.git /moosefs
RUN autoreconf -f -i
RUN ./configure --prefix=/usr --mandir=/share/man --sysconfdir=/etc --localstatedir=/var/lib --with-default-user=mfs --with-default-group=mfs --disable-mfsbdev --disable-mfsmount --disable-mfsmaster --disable-mfsmetalogger --disable-mfsnetdump --disable-mfschunkserver 
RUN make DESTDIR=/tmp/mfs install

#Build moosefs-cgi container
FROM python:3.13-bookworm
COPY --from=mfsbuilder /tmp/mfs/usr /usr
COPY --from=mfsbuilder /tmp/mfs/var /var

# Expose GUI port
EXPOSE 9425

# Container preparation
ADD cgiserver.sh /usr/sbin/cgiserver.sh
RUN set -eux; \
        useradd -r -d /var/lib/mfs -s /usr/sbin/nologin mfs; \
        chown -R mfs:mfs /usr/share/mfscgi; \
        chown root:root /usr/sbin/cgiserver.sh; \
        chmod 700 /usr/sbin/cgiserver.sh

CMD ["cgiserver.sh"]
