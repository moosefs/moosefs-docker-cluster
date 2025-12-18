# Build MooseFS GUI server from source on Debian Trixie (13) container

ARG MFS_TAG="v4.58.3"

FROM moosefs/mfsbuilder:trixie AS mfsbuilder
WORKDIR /moosefs
ARG MFS_TAG
RUN git clone --depth 1 --branch ${MFS_TAG} https://github.com/moosefs/moosefs.git /moosefs
RUN set -eux; \
    autoreconf -f -i; \
    ./configure --prefix=/usr --mandir=/share/man --sysconfdir=/etc --localstatedir=/var/lib \
    --with-default-user=mfs --with-default-group=mfs --disable-mfsbdev --disable-mfsmount \
    --disable-mfsmaster --disable-mfsmetalogger --disable-mfsnetdump --disable-mfschunkserver; \
    make DESTDIR=/tmp/mfs install

#Build moosefs-gui container
FROM python:3.13-trixie
COPY --from=mfsbuilder /tmp/mfs/usr /usr
COPY --from=mfsbuilder /tmp/mfs/var /var

# Expose GUI port
EXPOSE 9425

# Container preparation
ADD gui.sh /usr/sbin/gui.sh
RUN set -eux; \
    useradd -r -d /var/lib/mfs -s /usr/sbin/nologin mfs; \
    chown -R mfs:mfs /usr/share/mfscgi; \
    chown -R mfs:mfs /var/lib/mfs; \
    chown root:root /usr/sbin/gui.sh; \
    chmod 700 /usr/sbin/gui.sh

CMD ["gui.sh"]
