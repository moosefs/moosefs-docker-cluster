# Build MooseFS master server from source on Debian Trixie (13) container

ARG MFS_TAG="v4.58.1"

FROM moosefs/mfsbuilder:trixie AS mfsbuilder
WORKDIR /moosefs
ARG MFS_TAG
RUN git clone --depth 1 --branch ${MFS_TAG} https://github.com/moosefs/moosefs.git /moosefs
RUN set -eux; \
    autoreconf -f -i; \
    ./configure --prefix=/usr --mandir=/share/man --sysconfdir=/etc \
    --localstatedir=/var/lib --with-default-user=mfs --with-default-group=mfs \
    --disable-mfsbdev --disable-mfsmount --disable-mfschunkserver \
    --disable-mfsmetalogger --disable-mfsnetdump --disable-mfsgui --disable-mfscli; \
    make DESTDIR=/tmp/mfs install

#Build moosefs-master container
FROM debian:trixie
COPY --from=mfsbuilder /tmp/mfs/etc /etc
COPY --from=mfsbuilder /tmp/mfs/usr /usr
COPY --from=mfsbuilder /tmp/mfs/var /var

# Expose master ports
EXPOSE 9419 9420 9421

# Container preparation
ADD master.sh /usr/sbin/master.sh
RUN set -eux; \
    useradd -r -d /var/lib/mfs -s /usr/sbin/nologin mfs; \
    cp /etc/mfs/mfsexports.cfg.sample /etc/mfs/mfsexports.cfg; \
    chown root:root /usr/sbin/master.sh; \
    chmod 700 /usr/sbin/master.sh

CMD ["master.sh"]
