ARG MFS_TAG="v4.57.6"

# Build MooseFS client binaries from source
# MFSbuilder image is based on Debian 12
FROM ghcr.io/moosefs/mfsbuilder:latest AS mfsbuilder
WORKDIR /moosefs
ARG MFS_TAG
RUN git clone --depth 1 --branch ${MFS_TAG} https://github.com/moosefs/moosefs.git /moosefs
RUN set -eux; \
    autoreconf -f -i; \
    ./configure --prefix=/usr --mandir=/share/man --sysconfdir=/etc \
    --localstatedir=/var/lib --with-default-user=mfs --with-default-group=mfs \
    --disable-mfsbdev --disable-mfsmaster --disable-mfschunkserver \
    --disable-mfsmetalogger --disable-mfsnetdump --disable-mfscgi \
    --disable-mfscgiserv --disable-mfscli; \
    make DESTDIR=/tmp/mfs install

#Build moosefs-client container
FROM debian:bookworm
COPY --from=mfsbuilder /tmp/mfs/etc /etc
COPY --from=mfsbuilder /tmp/mfs/usr /usr

# Container preparation
ADD mount.sh /usr/sbin/mount.sh
RUN set -eux; \
    apt-get update; \
    apt-get install libfuse3-3 fuse3 -y; \
    ln -s /usr/bin/mfsmount /usr/sbin/mfsmount; \
    chown root:root /usr/sbin/mount.sh; \
    chmod 700 /usr/sbin/mount.sh; \
    mkdir -p /mnt/moosefs

CMD ["mount.sh"]
