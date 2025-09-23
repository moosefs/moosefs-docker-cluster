# Build MooseFS client from source on Debian Trixie (13) container

ARG MFS_TAG="v4.58.0"

FROM moosefs/mfsbuilder:trixie AS mfsbuilder
WORKDIR /moosefs
ARG MFS_TAG
RUN git clone --depth 1 --branch ${MFS_TAG} https://github.com/moosefs/moosefs.git /moosefs
RUN set -eux; \
    autoreconf -f -i; \
    ./configure --prefix=/usr --mandir=/share/man --sysconfdir=/etc \
    --localstatedir=/var/lib --with-default-user=mfs --with-default-group=mfs \
    --disable-mfsbdev --disable-mfsmaster --disable-mfschunkserver \
    --disable-mfsmetalogger --disable-mfsnetdump --disable-mfsgui --disable-mfscli; \
    make DESTDIR=/tmp/mfs install

#Build moosefs-client container
FROM debian:trixie
COPY --from=mfsbuilder /tmp/mfs/etc /etc
COPY --from=mfsbuilder /tmp/mfs/usr /usr

# Container preparation
ADD mount.sh /usr/sbin/mount.sh
RUN set -eux; \
    apt-get update; \
    apt-get install libfuse3-4 fuse3 -y; \
    ln -s /usr/bin/mfsmount /usr/sbin/mfsmount; \
    chown root:root /usr/sbin/mount.sh; \
    chmod 700 /usr/sbin/mount.sh; \
    mkdir -p /mnt/moosefs

CMD ["mount.sh"]
