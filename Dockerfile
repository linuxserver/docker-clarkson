FROM ghcr.io/linuxserver/baseimage-alpine:3.12

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CLARKSON_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	build-base \
	curl \
	libsass-dev \
	nodejs-npm \
	tar \
	python2 && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	nodejs \
        nss \
        openjdk8-jre \
        sqlite-libs && \
 echo "**** install clarkson ****" && \
 if [ -z ${CLARKSON_RELEASE+x} ]; then \
	CLARKSON_RELEASE=$(curl -sX GET "https://api.github.com/repos/linuxserver/Clarkson/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 mkdir -p \
	/app/clarkson && \
 curl -o \
 /tmp/clarkson-src.tar.gz -L \
	"https://github.com/linuxserver/Clarkson/archive/${CLARKSON_RELEASE}.tar.gz" && \
 tar xf \
 /tmp/clarkson-src.tar.gz -C \
	/app/clarkson --strip-components=1 && \
 cd /app/clarkson && \
 echo "**** make flway executable ****" && \
 chmod +x ./flyway/flyway && \
 echo "**** install clarkson node dev modules and build ****" && \
 npm config set unsafe-perm true && \
 npm install && \
 /app/clarkson/node_modules/@angular/cli/bin/ng build --prod && \
 echo "**** cleanup ****" && \
 cd /app/clarkson && \
 npm run prune-angular2 && \
 npm prune --production && \
 apk del --purge build-dependencies && \
 rm -rf \
	/root \
	/tmp/* && \
 mkdir -p \
	/root

# copy local files
COPY root/ /
