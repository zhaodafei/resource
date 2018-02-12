数据库应用(Mysql、Mongodb、Redis、Memcached、CouchDB、Cassandra)

目前，主流数据库包括关系型（SQL）和非关系型（NoSQL）两种。

关系数据库是建立在关系模型基础上的数据库，借助于集合代数等数学概念和方法来处理数据库中的数据，支持复杂的事物处理和结构化查询。代表实现有MySQL、Oracle、PostGreSQL、MariaDB、SQLServer等。

非关系数据库是新兴的数据库技术，它放弃了传统关系型数据库的部分强一致性限制，带来性能上的提升，使其更适用于需要大规模并行处理的场景。非关系型数据库是关系型数据库的良好补充，代表产品有MongoDB、Memcached、CouchDB、Cassandra等。

## MySQL
MySQL是全球最流行的开源的开源关系数据库软件之一，因为其高性能、成熟可靠和适应性而得到广泛应用。MySQL目前在不少大规模网站和应用中被使用。

使用官方镜像可以快速启动一个MySQL Server实例，如下所示：

```
$ docker run --name hi-mysql -e MYSQL_ROOT_PASSWORD=123 -d mysql:latest

e6cb906570549812c798b7b3ce46d669a8a4e8ac62a3f3c8997e4c53d16301b6
```

以上指令中的hi-mysql是容器名称，123为数据库的root密码。

使用docker ps指令可以看到现在运行中的容器：
```
$ docker ps

CONTAINER ID  IMAGE  COMMAND                CREATED       STATUS       PORTS     NAMES

e6cb90657054  mysql  "docker-entrypoint.sh" 4 minutes ago Up 3 minutes 3306/tcp  hi-mysql
```

当然，还可以使用--link标签将一个应用容器连接至MySQL容器：
```
$ docker run --name some-app --link some-mysql:mysql -d application-that-uses-mysql
```
MySQL服务的标准端口是3306，用户可以通过CLI工具对配置进行修改：
```
$ docker run -it --link some-mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P "$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
```
官方MySQL镜像还可以作为客户端，连接非Docker或者远程的MySQL实例：
```
$ docker run -it --rm mysql mysql -hsome.mysql.host -usome-mysql-user -p
```
### 1.系统与日志访问

用户可以使用docker exec指令调用内部系统中的bash shell，以访问容器内部系统：
```
$ docker exec -it some-mysql bash
```
MySQL Server日志可以使用docker logs指令查看：
```
$ docker logs some-mysql
```
### 2.使用自定义配置文件

如果用户希望使用自定义MySQL配置，则可以创建一个目录，内置cnf配置文件，然后将其挂载至容器的/etc/mysql/conf.d目录。

比如，自定义配置文件为/my/custom/config-file.cnf，则可以使用以下指令：
```
$ docker run --name some-mysql -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
```
这是新的容器some-mysql启动后，就会结合使用/etc/mysql/my.cnf和/etc/mysql/conf.d/config-file.cnf两个配置文件。

### 3.脱离cnf文件进行配置

很多的配置选项可以通过标签（flags）传递至mysqld进程。这样用户就可以脱离cnf配置文件，对容器进行弹性的定制。

比如，用户需要改变默认编码方式，将所有表格的编码方式修改为uft8mb4，则可以使用以下指令：
```
$ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```
如果需要查看可用选项的完整列表，可以执行：
```
$ docker run -it --rm mysql:tag --verbose --help
```
## MongoDB
MongoDB是一款可扩展、高性能的开源文档数据库，是当今最流行的NoSQL数据库软件之一。它采用C++开发，支持复杂的数据类型和强大的查询语言，提供了关系数据库的绝大部分功能。由于MongoDB高性能、易部署、易使用等特点，已经在很多领域都得到了广泛的应用。

使用官方镜像

用户可以使用docker run指令直接运行官方mongodb镜像：
```
$ docker run --name mongo-container -d mongo

ade2b5036f457a6a2e7574fd68cf7a3298936f27280833769e93392015512735
```
之后，可以通过docker ps指令查看正在运行的mongo-container容器的容器ID：
```
$ docker ps

CONTAINER ID IMAGE COMMAND                CREATED     STATUS      PORTS NAMES

ade2b5036f45 mongo "/entrypoint.sh mongo" 1 hours ago Up 22 hours 27017/tcp  mongo-container
```

在此mongo容器启动一个bash进程，并通过mongo指令启动mongodb交互命令行，再通过db.stats()指令查看数据库状态：
```
$ docker exec -it ade2b5036f45 sh
```

```
# mongo
MongoDB shell version: 3.2.6
connecting to: test
> show dbs
local  0.000GB
> db.stats()
{
"db" : "test",
"collections" : 1,
"objects" : 1,
"avgObjSize" : 39,
"dataSize" : 39,
"storageSize" : 16384,
"numExtents" : 0,
"indexes" : 1,
"indexSize" : 16384,
"ok" : 1
}
```

这里用户可以通过env指令查看环境变量的配置：

```
root@ade2b5036f45:/bin# env
HOSTNAME=ade2b5036f45
MONGO_VERSION=3.2.6
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
GPG_KEYS=DFFA3DCF326E302C4787673A01C4E7FAAAB2461C     42F3E95A2C4F08279C4960ADD
68FA50FEA312927
PWD=/bin
SHLVL=1
HOME=/root
MONGO_MAJOR=3.2
GOSU_VERSION=1.7
_=/usr/bin/env
OLDPWD=/
```

镜像默认暴露了mongodb的服务端口：27017，可以通过该端口访问服务。

### 1.连接mongodb容器

使用--link参数，连接新建的mongo-container容器：

```
$ docker run -it --link mongo-container:db alpine sh

/ # ls
```
进入alpine系统容器后，用户可以使用ping指令测试db容器的连通性：
```
/ # ping db
```

### 2.直接使用mongo cli指令

如果想直接在宿主机器上使用mongodb镜像，可以在docker run指令后面加入entrypoint指令，这样就可以非常方便的直接进入mongo cli了。
```
$ docker run -it --link mongo-container:db --entrypoint mongo mongo --host db
```

```
> db.version();
3.2.6
>  db.stats();
{
"db" : "test",
"collections" : 0,
"objects" : 0,
"avgObjSize" : 0,
"dataSize" : 0,
"storageSize" : 0,
"numExtents" : 0,
"indexes" : 0,
"indexSize" : 0,
"fileSize" : 0,
"ok" : 1
}
> show dbs
local  0.000GB
```

最后，还可以使用--storageEngine参数来设置储存引擎：
```
$ docker run --name mongo-container -d mongo --storageEngine wiredTiger
```

### 使用自定义Dockerfile

第一步：准备工作。

新建项目目录，并在根目录新建Dockerfile，内容如下：

```
#设置从用户之前创建的sshd镜像继承。
FROM sshd
MAINTAINER docker_user (user@docker.com)
RUN apt-get update && \
apt-get install -y mongodb pwgen && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
#创建mongodb存放数据文件的文件夹
RUN mkdir -p /data/db
VOLUME /data/db
ENV AUTH yes
#添加脚本
ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod 755 ./*.sh
EXPOSE 27017
EXPOSE 28017
CMD ["/run.sh"]
```

新建set_mongodb_password.sh脚本。此脚本主要负责配置数据库的用户名和密码：

```
#!/bin/bash
#这个脚本主要是用来设置数据库的用户名和密码。
#判断是否已经设置过密码。
if [ -f /.mongodb_password_set ]; then
echo "MongoDB password already set!"
exit 0
fi
/usr/bin/mongod --smallfiles --nojournal &
PASS=${MONGODB_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "random" )
RET=1
while [[ RET -ne 0 ]]; do
echo "=> Waiting for confirmation of MongoDB service startup"
sleep 5
mongo admin --eval "help" >/dev/null 2>&1
RET=$?
done
#通过docker logs + id可以看到下面的输出。
echo "=> Creating an admin user with a ${_word} password in MongoDB"
mongo admin --eval "db.addUser({user: 'admin', pwd: '$PASS', roles:
[ 'userAdminAnyDatabase', 'dbAdminAnyDatabase' ]});"
mongo admin --eval "db.shutdownServer();"
echo "=> Done!"
touch /.mongodb_password_set
echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo admin -u admin -p $PASS --host --port "
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
```

新建run.sh，此脚本是主要的mongodb启动脚本：

```
#!/bin/bash
if [ ! -f /.mongodb_password_set ]; then
/set_mongodb_password.sh
fi
if [ "$AUTH" == "yes" ]; then
#这里可以自己设定Mongodb的启动参数。
export mongodb='/usr/bin/mongod --nojournal --auth --httpinterface --rest'
else
export mongodb='/usr/bin/mongod --nojournal --httpinterface --rest'
fi
if [ ! -f /data/db/mongod.lock ]; then
eval $mongodb
else
export mongodb=$mongodb' --dbpath /data/db'
rm /data/db/mongod.lock
mongod --dbpath /data/db --repair && eval $mongodb
fi
```
第二步，使用docker build指令构建镜像：
```
$ docker build  -t mongodb-image .
```
第三步，启动后台容器，并分别映射27017和28017端口到本地：
```
$ docker run -d -p 27017:27017 -p 28017:28017 mongodb
```
通过docker logs来查看默认的admin帐户密码：
```
$ docker logs sa9

=======================================================================
You can now connect to this MongoDB server using:
mongo admin -u admin -p 5elsT6KtjrqV --host --port
Please remember to change the above password as soon as possible!
=======================================================================
```

屏幕输出中的5elsT6KtjrqV就是admin用户的密码。

也可以利用环境变量在容器启动时指定密码：
```
$  docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" mongodb
```
甚至，设定不需要密码即可访问：
```
$  docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no mongodb
```
同样，也可以使用-v参数来映射本地目录到容器。

## Redis
Redis是一个开源（BSD许可）的基于内存的数据结构存储系统，可以用作数据库、缓存和消息中间件。

通过docker run指令可以直接启动一个redis-container容器：
```
$ docker run --name redis-container -d redis

6f7d16f298e9c505f35ae28b61b4015877a5b0b75c60797fa4583429e4a14e24
```
之后可以通过docker ps指令查看正在运行的redis-container容器的容器ID：
```
$ docker ps

CONTAINER ID IMAGE COMMAND                CREATED        STATUS        PORTS        NAMES

6f7d16f298e9 redis "docker-entrypoint.sh" 32 seconds ago Up 31 seconds 6379/tcp   redis-container
```
在此redis容器启动bash，并查看容器的运行时间和内存状况：
```
$ docker exec -it 6f7d16f298e9 bash
```

```
root@6f7d16f298e9:/data# uptime
12:26:19 up 20 min,  0 users,  load average: 0.00, 0.04, 0.10
root@6f7d16f298e9:/data# free
total       used       free     shared    buffers     cached
Mem:       1020096     699280     320816     126800      50184     527260
-/+ buffers/cache:     121836     898260
Swap:      1181112          0    1181112
```
同样可以通过env指令查看环境变量的配置：

```
root@6f7d16f298e9:/data# env
HOSTNAME=6f7d16f298e9
REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-3.0.7.tar.gz
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/data
SHLVL=1
HOME=/root
REDIS_DOWNLOAD_SHA1=e56b4b7e033ae8dbf311f9191cf6fdf3ae974d1c
REDIS_VERSION=3.0.7
GOSU_VERSION=1.7
_=/usr/bin/env
```
也可以通过ps指令查看当前容器运行的进程信息：
```
root@6f7d16f298e9:/data# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
redis        1     0   0 12:16 ?        00:00:02 redis-server *:6379
root        30     0   0 12:51 ?        00:00:00 sh
root        39    30   0 12:52 ?        00:00:00 ps -ef
```
### 1.连接redis容器

用户可以使用--link参数，连接创建的redis-container容器：
```
$ docker run -it --link redis-container:db alpine sh

/ # ls
```
进入alpine系统容器后，可以使用ping指令测试redis容器：
```
/ # ping db
```
还可以使用nc指令（即NetCat）检测redis服务的可用性：
```
/ # nc db 6379
```
官方镜像内也自带了redis客户端，可以使用以下指令直接使用：
```
$ docker run -it --link redis-container:db --entrypoint redis-cli redis -h db

db:6379> ping
PONG
db:6379> set 1 2
OK
db:6379> get 1
"2"
```

### 2.使用自定义配置

可以通过数据卷实现自定义redis配置，如下所示：
```
$ docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf --name myredis redis redis-server /usr/local/etc/redis/redis.conf
```

## Memcached
Memcached是一个高性能、分布式的开源内存对象缓存系统。Memcached守护进程基于C语言实现，基于libevent的事件处理可以实现很高的性能。需要注意的是，由于数据仅存在于内存中，因此重启Memcached或重启操作系统会导致数据全部丢失。

可以直接通过官方提供的memcached镜像运行一个memcached-container容器：
```
$ docker run --name memcached-container -d memcached

94e957b52be9a254954cddd23d64ba520493519a19c2e548b4e3dd7f41475b2a
```
在docker run指令中可以设定memcached server使用的内存大小：
```
$ docker run --name memcached-container-2 -d memcached memcached -m 64

bde9544643ac2a43945322c9bde76342dfc55db12875973da83408a8d239f94c
```
以上指令会将memcached server的内存使用量设置为64MB。

此时，用户可以在宿主机器直接telnet测试访问memcached容器，并直接输入客户端命令：

```
$ telnet 192.168.99.100 11211
Trying 192.168.99.100...
Connected to 192.168.99.100.
Escape character is '^]'.
stats
STAT pid 1
STAT uptime 19
STAT time 1462972021
STAT version 1.4.25
...
END
```
## CouchDB
CouchDB是一款面向文档的NoSQL数据库，以JSON格式存储数据。它兼容ACID，可以用于存储网站的数据与内容，以及提供缓存等。CouchDB里文档域（Field）都是以键值对的形式存储的，对数据的每次修改都会得到一个新的文档修订号。CouchDB侧重于AP（可用性和分区容忍度）。相比之下，MongoDB侧重于CP（一致性和分区容忍度）。

可以直接使用docker run指令运行官方镜像，如下所示：
```
$ docker run -d --name couchdb-container couchdb

50badad3e71da22b77bfd5522b27aa77299b649560254343d4a0c80c52a37c36
```
这个镜像中CouchDB的默认端口是5984，用户可以使用link指令进行容器链接：
```
$ docker run --name couchdb-app --link couchdb-container:couch couchdb
```
获取容器IP之后，用户可以使用curl指令，通过CouchDB API来操作CouchDB容器：
```
$ curl http://192.168.99.100:5984

{"couchdb":"Welcome","uuid":"7298b57db384b931f43bbc8c49e75b53","version":"1.6.1",

"vendor":{"name":"The Apache Software Foundation","version":"1.6.1"}}
```

## Cassandra
Cassandra是个开源（Apache License 2.0）的分布式数据库，支持分散的数据存储，可以实现容错以及无单点故障等。Cassandra在设计上引入了P2P技术，具备大规模可分区行存储能力，并支持Spark、Storm、Hadoop的集成。目前Facebook、Twitter、Instagram、eBay、Github、Reddit、Netflix等多家公司都在使用Cassandra。类似工具还有HBase等。

### 1.使用官方镜像

首先可以使用docker run指令基于Cassandra官方镜像启动容器：
```
$ docker run --name my-cassandra -d cassandra:latest

1dde81cddc53322817f8c6e67022c501759d8d187a2de40f1a25710a5f2dfa53
```
这里的--name标签指定容器名称。cassandra:tag中的标签指定版本号。

标签名称可以参考官方仓库的标签说明：https://hub.docker.com/r/library/cassandra/tags/。

用户可以将另一个容器中的应用与Cassandra容器连接起来。此应用容器要暴露Cassandra需要使用的端口（Cassandra默认服务端口为rpc_port:9160；CQL默认本地服务端口为native_transport_port:9042），这样就可以通过容器link功能来连接Cassandra容器与应用容器：
```
$ docker run --name my-app --link my-cassandra:cassandra -d app-that-uses-cassandra
```

### 2.搭建Cassandra集群

Cassandra有两种集群模式：单机模式（所有实例集中于一台机器）和多机模式（实例分布于多台机器）。

单机模式下，可以按照上面描述的方法启动容器即可。

如果需要启动更多实例，则需要在指令中配置首个实例信息：
```
$ docker run --name my-cassandra2 -d -e CASSANDRA_SEEDS="$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' my-cassandra)" cassandra:latest
```

其中my-cassandra就是首个Cassandra Server的实例名称。在这里使用了docker inspect指令，以获取首个实例的IP地址信息。

还可以使用docker run的--link标签来连接这两个Cassandra实例：
```
$ docker run --name my-cassandra2 -d --link my-cassandra:cassandra cassandra:latest
```
多机模式下，由于容器网络基于Docker bridge，所以需要通过环境变量配置Cassandra Server容器的IP广播地址（即使用-e标签）。

假设第一台虚拟机的IP是10.22.22.22，第二台虚拟机的IP是10.23.23.23，Gossip端口是7000。

那么启动第一台虚拟机中的Cassandra容器时的指令如下：
```
$ docker run --name my-cassandra -d -e CASSANDRA_BROADCAST_ADDRESS=10.42.42.42 -p 7000:7000 cassandra:latest
```
启动第二台虚拟机的Cassandra容器时，同样需要暴露Gossip端口，并通过环境变量声明第一台Cassandra容器的IP地址：
```
$ docker run --name my-cassandra -d -e CASSANDRA_BROADCAST_ADDRESS=10.43.43.43 -p 7000:7000 -e CASSANDRA_SEEDS=10.42.42.42 cassandra:latest
```
小结

在使用数据库容器时，建议将数据库文件映射到宿主主机，一方面减少容器文件系统带来的性能损耗，另一方面实现数据的持久化。