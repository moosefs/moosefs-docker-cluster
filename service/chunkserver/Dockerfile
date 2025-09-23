# Build MooseFS chunnkserver from source on Debian Trixie (13) container

ARG MFS_TAG="v4.58.0"

FROM moosefs/mfsbuilder:trixie AS mfsbuilder
WORKDIR /moosefs
ARG MFS_TAG
RUN git clone --depth 1 --branch ${MFS_TAG} https://github.com/moosefs/moosefs.git /moosefs
RUN set -eux; \
    autoreconf -f -i; \
    ./configure --prefix=/usr --mandir=/share/man --sysconfdir=/etc \
    --localstatedir=/var/lib --with-default-user=mfs --with-default-group=mfs \
    --disable-mfsbdev --disable-mfsmount --disable-mfsmaster \
    --disable-mfsmetalogger --disable-mfsnetdump --disable-mfsgui --disable-mfscli; \
    make DESTDIR=/tmp/mfs install

#Build moosefs-chunkserver container
FROM debian:trixie
COPY --from=mfsbuilder /tmp/mfs/etc /etc
COPY --from=mfsbuilder /tmp/mfs/usr /usr
COPY --from=mfsbuilder /tmp/mfs/var /var

# Expose chunkserver port
EXPOSE 9422

# Container preparation
ADD chunkserver.sh /usr/sbin/chunkserver.sh
RUN set -eux; \
    useradd -r -d /var/lib/mfs -s /usr/sbin/nologin mfs; \
    chown root:root /usr/sbin/chunkserver.sh; \
    chmod 700 /usr/sbin/chunkserver.sh; \
    mkdir -p /mnt/hdd0

CMD ["chunkserver.sh"]
