FROM lsiobase/alpine:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \

 # Install temp build dependencies
 apk add --no-cache --virtual=build-dependencies \
	curl \
	nodejs-npm \
	tar \
        python \
	yarn && \

 # Install permanent build dependencies
 apk add --no-cache \
	nodejs \
        openjdk8-jre && \

 # Get node deps for run process
 npm install -g node-gyp ts-node typescript && \

 # Use Yarn to get angular because npm flaps
 yarn global add @angular/cli && \
 yarn cache clean && \

 # Prepare app directory
 mkdir -p \
	/app/clarkson && \

 # Get latest version of Clarkson
 curl -o \
 /tmp/clarkson-src.tar.gz -L \
	"https://github.com/linuxserver/Clarkson/archive/master.tar.gz" && \
 tar xf \
 /tmp/clarkson-src.tar.gz -C \
	/app/clarkson --strip-components=1 && \
 cd /app/clarkson && \

 # Make flyway executable
 chmod +x ./flyway/flyway && \

 # Grab all dependencies for the application itself
 npm install && \

 # Remove leftover deps
 apk del --purge build-dependencies && \
 rm -rf \
	/root \
	/tmp/*

# Add startup files
COPY root/ /
