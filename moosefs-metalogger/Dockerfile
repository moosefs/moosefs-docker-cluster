ARG MFS_TAG="v4.57.6"

# Build MooseFS metalogger binaries from source
# MFSbuilder image is based on Debian 12
FROM ghcr.io/moosefs/mfsbuilder:latest AS mfsbuilder
WORKDIR /moosefs
ARG MFS_TAG
RUN git clone --depth 1 --branch ${MFS_TAG} https://github.com/moosefs/moosefs.git /moosefs
RUN set -eux; \
    autoreconf -f -i; \
    ./configure --prefix=/usr --mandir=/share/man --sysconfdir=/etc \
    --localstatedir=/var/lib --with-default-user=mfs --with-default-group=mfs \
    --disable-mfsbdev --disable-mfsmount --disable-mfschunkserver \
    --disable-mfsmaster --disable-mfsnetdump --disable-mfscgi --disable-mfscgiserv --disable-mfscli; \
    make DESTDIR=/tmp/mfs install

# Build moosefs-metalogger container
FROM debian:bookworm
COPY --from=mfsbuilder /tmp/mfs/etc /etc
COPY --from=mfsbuilder /tmp/mfs/usr /usr
COPY --from=mfsbuilder /tmp/mfs/var /var

# Container preparation
ADD metalogger.sh /usr/sbin/metalogger.sh
RUN set -eux; \
    useradd -r -d /var/lib/mfs -s /usr/sbin/nologin mfs; \
    cp /etc/mfs/mfsmetalogger.cfg.sample /etc/mfs/mfsmetalogger.cfg; \
    chown root:root /usr/sbin/metalogger.sh; \
    chmod 700 /usr/sbin/metalogger.sh

CMD ["metalogger.sh"]
