[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: www.example.com
[hub]: https://hub.docker.com/r/linuxserver/clarkson/


[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png?v=4&s=4000)][linuxserverurl]


## Contact information:- 

| Type | Address/Details | 
| :---: | --- |
| Discord | [Discord](https://discord.gg/YWrKVTn) |
| Forum | [Linuserver.io forum][forumurl] |
| IRC | freenode at `#linuxserver.io` more information at:- [IRC][ircurl]
| Podcast | Covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation! [Linuxserver.io Podcast][podcasturl] |


The [LinuxServer.io][linuxserverurl] team brings you another image release featuring :-

 + regular and timely application updates
 + easy user mappings
 + custom base image with s6 overlay
 + weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 + security updates

# linuxserver/clarkson
[![](https://images.microbadger.com/badges/version/linuxserver/clarkson.svg)](https://microbadger.com/images/linuxserver/clarkson "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/clarkson.svg)](https://microbadger.com/images/linuxserver/clarkson "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/clarkson.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/clarkson.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-clarkson)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-clarkson/)

Provide a short, concise description of the application. No more than two SHORT paragraphs. Link to sources where possible and include an image illustrating your point if necessary. Point users to the original applications website, as that's the best place to get support - not here.

`IMPORTANT, replace all instances of linuxserver/clarkson with the correct dockerhub repo (ie linuxserver/plex) and clarkson information (ie, plex)`

&nbsp;

## Usage

```
docker create \
  --name=clarkson \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 1234:1234 \
  linuxserver/clarkson
```

&nbsp;

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.



| Parameter | Function |
| :---: | --- |
| `-p 1234` | the port(s) |
| `-v /config` | explain what lives here |
| `-e PGID` | for GroupID, see below for explanation |
| `-e PUID` | for UserID, see below for explanation |

&nbsp;

## User / Group Identifiers

Sometimes when using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and it will "just work" &trade;.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

&nbsp;

## Setting up the application

Insert a basic user guide here to get a n00b up and running with the software inside the container. DELETE ME


&nbsp;

## Container access and information.

| Function | Command |
| :--- | :--- |
| Shell access (live container) | `docker exec -it clarkson /bin/bash` |
| Realtime container logs | `docker logs -f clarkson` |
| Container version number | `docker inspect -f '{{ index .Config.Labels "build_version" }}' clarkson` |
| Image version number |  `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/clarkson` |

&nbsp;

## Versions

|  Date | Changes |
| :---: | --- |
| dd.MM.yy |  Initial Release. |
