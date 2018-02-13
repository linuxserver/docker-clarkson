FROM lsiobase/alpine:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	nodejs-npm \
	tar \
	python \
	yarn && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	nodejs \
	openjdk8-jre && \
 echo "**** install node packages ****" && \
 npm install -g \
	node-gyp \
	ts-node \
	typescript && \
 echo "**** install angular-cli ****" && \
 yarn global add @angular/cli && \
 yarn cache clean && \
 echo "**** install clarkson ****" && \
 mkdir -p \
	/app/clarkson && \
 curl -o \
 /tmp/clarkson-src.tar.gz -L \
	"https://github.com/linuxserver/Clarkson/archive/master.tar.gz" && \
 tar xf \
 /tmp/clarkson-src.tar.gz -C \
	/app/clarkson --strip-components=1 && \
 cd /app/clarkson && \
 chmod +x ./flyway/flyway && \
 npm install && \
 echo "**** cleanup ****" && \
 apk del --purge build-dependencies && \
 rm -rf \
	/root \
	/tmp/* && \
 mkdir -p \
	/root

# copy local files
COPY root/ /
