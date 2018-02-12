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
	python \
	tar \
	yarn && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	nodejs && \
 echo "**** install node packages and angular-cli ****" && \
 npm install -g ts-node typescript && \
 yarn global add @angular/cli && \
 yarn cache clean && \
 echo "**** install clarkson ****" && \
 mkdir -p \
	/app/clarkson&& \
 curl -o \
 /tmp/clarkson-src.tar.gz -L \
	"https://github.com/linuxserver/Clarkson/archive/master.tar.gz" && \
 tar xf \
 /tmp/clarkson-src.tar.gz -C \
	/app/clarkson --strip-components=1 && \
 cd /app/clarkson && \
 npm install && \
 ng build --prod && \
 echo "**** cleanup ****" && \
 apk del --purge build-dependencies && \
 rm -rf \
	/root \
	/tmp/* && \
 mkdir -p /root
