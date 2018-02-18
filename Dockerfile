FROM lsiobase/alpine:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
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
	python \
	yarn && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	nodejs \
	openjdk8-jre && \
 echo "**** install node packages ****" && \
 npm config set unsafe-perm true && \
 npm install -g \
	node-gyp && \
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
 echo "**** make flway executable ****" && \
 chmod +x ./flyway/flyway && \
 echo "**** install clarkson node dev modules and build ****" && \
 npm install && \
 ng build --prod && \
 echo "**** cleanup ****" && \
 cd /app/clarkson && \
 npm run prune-angular2 && \
 npm prune --production && \
 yarn global remove \
	@angular/cli && \
 yarn cache clean && \
 npm uninstall -g \
	node-gyp && \
 apk del --purge build-dependencies && \
 rm -rf \
	/root \
	/tmp/* && \
 mkdir -p \
	/root

# copy local files
COPY root/ /
