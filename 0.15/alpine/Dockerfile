
# Build stage for BerkeleyDB
FROM alpine as berkeleydb

RUN apk --no-cache add autoconf
RUN apk --no-cache add automake
RUN apk --no-cache add build-base
RUN apk --no-cache add libressl

ENV BERKELEYDB_VERSION=db-4.8.30.NC
ENV BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}

RUN wget https://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz
RUN tar -xzf *.tar.gz
RUN sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BERKELEYDB_VERSION}/dbinc/atomic.h
RUN mkdir -p ${BERKELEYDB_PREFIX}

WORKDIR /${BERKELEYDB_VERSION}/build_unix

RUN ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX}
RUN make -j4
RUN make install
RUN rm -rf ${BERKELEYDB_PREFIX}/docs

# Build stage for Bitcoin Gold
FROM alpine:3.9 as bitcoin-gold

COPY --from=berkeleydb /opt /opt

RUN apk --no-cache add autoconf
RUN apk --no-cache add automake
RUN apk --no-cache add boost-dev
RUN apk --no-cache add build-base
RUN apk --no-cache add chrpath
RUN apk --no-cache add file
RUN apk --no-cache add gnupg
RUN apk --no-cache add libevent-dev
RUN apk --no-cache add libressl
RUN apk --no-cache add libressl-dev
RUN apk --no-cache add libsodium-dev
RUN apk --no-cache add libtool
RUN apk --no-cache add linux-headers
RUN apk --no-cache add protobuf-dev
RUN apk --no-cache add zeromq-dev

RUN set -ex \
  && for key in \
    38EE12EB597B4FC0 \
  ; do \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
  gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
  gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
  gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done

ENV BITCOIN_GOLD_VERSION=0.15.2
ENV BITCOIN_GOLD_FOLDER_VERSION=0.15.2
ENV BITCOIN_GOLD_PREFIX=/opt/bitcoin-gold-${BITCOIN_GOLD_VERSION}
ENV BITCOIN_GOLD_SHASUM="b0e568e87ce4b3ca7a3170c12fc039a94c412cbceefadeb3e7bc13c282007759  ${BITCOIN_GOLD_FOLDER_VERSION}.tar.gz"
