FROM postgres:9.6

RUN apt-get -y --quiet update \
      && apt-get -y --quiet install curl wget pkg-config \
                                    git-core make automake autoconf libtool gcc \
                                    postgresql-server-dev-9.6 mongodb-dev
RUN git clone --recursive https://github.com/EnterpriseDB/mongo_fdw.git /tmp/fdw

RUN cd /tmp/fdw \
      && git checkout REL-5_2_6 \
      && ./autogen.sh --with-legacy \
      && sed -i 's/D_POSIX_SOURCE/D_GNU_SOURCE/' mongo-c-driver/Makefile \
      && make ; exit 0

RUN cd /tmp/fdw && make clean && make && make install