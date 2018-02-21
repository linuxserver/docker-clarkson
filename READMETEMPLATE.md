[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/linuxserver/Clarkson
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

Clarkson is a web-based dashboard application that gives you a neat and clean interface for logging your fuel fill-ups for all of your vehicles. The application has full multi-user support, as well as multiple vehicles per user. Whenever you fill-up your car or motorcycle, keep the receipt and record the data in Clarkson.

[![clarkson](https://raw.githubusercontent.com/linuxserver/Clarkson/master/docs/dashboard.png)][appurl]

&nbsp;

## Usage

```
docker create \
  --name=clarkson \
  -e PGID=<gid> -e PUID=<uid>  \
  -e MYSQL_HOST=<mysql_host> \
  -e MYSQL_USERNAME=<mysql_username> \
  -e MYSQL_PASSWORD=<mysql_password> \
  -e ENABLE_REGISTRATIONS=<true|false>
  -p 3000:3000 \
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
| `-p 3000` | the port(s) |
| `-e PGID` | for GroupID, see below for explanation |
| `-e PUID` | for UserID, see below for explanation |
| `-e MYSQL_HOST` | Points the backend to the MySQL database. This can be either a docker hostname or an IP |
| `-e MYSQL_USERNAME` | The user with access to the _clarkson_ schema |
| `-e MYSQL_PASSWORD` | The password for the user |
| `-e ENABLE_REGISTRATIONS` | **Defaults to _false_**. If set to _true_, allows new users to register |

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

**Please ensure MySQL is running before starting this container**.

It is preferred if you create the `clarkson` schema before initially running the container, then creating a user with granted permissions for the schema. Creating the schema before running the app is important as the "clarkson" user will not have permission to create the schema on your behalf. You can, of course, use the "root" user, which has the ability to create schemas automatically, but this is not recommended.

```sql
CREATE SCHEMA `clarkson`;
CREATE USER 'clarkson_user' IDENTIFIED BY 'supersecretpassword';
GRANT ALL ON `clarkson`.* TO 'clarkson_user';
```

Once running, the container will run an initial MySQL migration, which populates the schema with all tables and procedures. The application will start immediately afterwards. You will need to register an initial user, of which will be the admin of the application. All subsequent users will be standard users. You can disable registrations after the fact by recreating the container with the `ENABLE_REGISTRATIONS` flag set to `false`. This will not hide the "Register" link, but will disable the functionality.


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
| 19.02.18 |  Initial Release. |
