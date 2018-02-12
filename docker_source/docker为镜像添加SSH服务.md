为镜像添加SSH服务


>操作Docker容器介绍了一些进入容器的办法，比如attach、exec等命令，但是这些命令都无法解决远程管理容器的问题。因此，当需要远程登录到容器内进行一些操作的时候，就需要SSH的支持了。
如何自行创建一个带有SSH服务的镜像，并详细介绍了两种创建容器的方法：基于docker commit命令创建和基于Dockerfile创建。

## 基于commit命令创建
Docker提供了docker commit命令，支持用户提交自己对制定容器的修改，并生成新的镜像。

命令格式为docker commit CONTAINER [REPOSITORY[：TAG]]。

这里以ubuntu：14.04镜像添加SSH服务的操作流程为例。

### 1.准备工作

首先，使用ubuntu:14.04镜像来创建一个容器：
```
$ docker run -it ubuntu:14.04  /bin/bash
```
更新apt缓存，并安装openssh-server：
```
root@fc1936ea8ceb:/# apt-get update; apt-get install openssh-server -y
```

### 2.安装和配置SSH服务

选择主流的openssh-server作为服务端：
```
root@fc1936ea8ceb:/# apt-get install openssh-server –y
```
如果需要正常启动SSH服务，则目录/var/run/sshd必须存在，手动创建它，并启动SSH服务：
```
root@fc1936ea8ceb:/# mkdir -p /var/run/sshd

root@fc1936ea8ceb:/# /usr/sbin/sshd -D & [1] 3254
```
此时查看容器的22端口（SSH服务默认监听的端口），可见此端口已经处于监听状态：
```
root@fc1936ea8ceb:/# netstat -tunlp

Active Internet connections (only servers)

Proto Recv-Q Send-Q Local Address   Foreign Address   State    PID/Program name

tcp        0      0 0.0.0.0:22      0.0.0.0:*         LISTEN   -

tcp6       0      0 :::22           :::*              LISTEN   -
```
修改SSH服务的安全登录配置，取消pam登录限制：
```
root@fc1936ea8ceb:/# sed -ri 's/session    required     pam_loginuid.so/#session required     pam_loginuid.so/g' /etc/pam.d/sshd
```
在root用户目录下创建.ssh目录，并复制需要登录的公钥信息（一般为本地主机用户目录下的.ssh/id_rsa.pub文件，可由ssh-keygen-t rsa命令生成）到authorized_keys文件中：
```
root@fc1936ea8ceb:/# mkdir root/.ssh

cat /root/.ssh/id_rsa.pub >> authorized_keys

root@fc1936ea8ceb:/# vi /root/.ssh/authorized_keys
```
创建自动启动SSH服务的可执行文件run.sh，并添加可执行权限：
```
root@fc1936ea8ceb:/# vi /run.sh

root@fc1936ea8ceb:/# chmod +x run.sh
```
其中，run.sh脚本内容如下：
```
#!/bin/bash
/usr/sbin/sshd -D
```
最后，退出容器：
```
root@fc1936ea8ceb:/# exit

exit
```
### 3.保存镜像

将所退出的容器用docker commit命令保存为一个新的sshd:ubuntu镜像：
```
$ docker commit  fc1 sshd:ubuntu

7aef2cd95fd0c712f022bcff6a4ddefccf20fd693da2b24b04ee1cd3ed3eb6fc
```
使用docker images查看本地生成的新镜像sshd:ubuntu，目前拥有的镜像如下：
```
$ docker  images

REPOSITORY      TAG       IMAGE ID        CREATED             VIRTUAL SIZE

sshd            ubuntu    7aef2cd95fd0    10 seconds ago      255.2 MB

busybox         latest    e72ac664f4f0    3 weeks ago         2.433 MB

ubuntu          latest    ba5877dc9bec    3 months ago        192.7 MB
```
### 4.使用镜像

启动容器，并添加端口映射10022-->22。其中10022是宿主主机的端口，22是容器的SSH服务监听端口：
```
$ docker  run -p 10022:22  -d sshd:ubuntu /run.sh

3ad7182aa47f9ce670d933f943fdec946ab69742393ab2116bace72db82b4895
```
启动成功后，可以在宿主主机上看到容器运行的详细信息：
```
$ docker ps

CONTAINER ID   IMAGE            COMMAND   CREATED      STATUS           PORTS                           NAMES

3ad7182aa47f   sshd:ubuntu    "/run.sh"   2 seconds ago   Up 2 seconds  0.0.0.0:10022->22/tcp   focused_ptolemy
```
在宿主主机（192.168.1.200）或其他主机上上，可以通过SSH访问10022端口来登录容器：
```
$ ssh 192.168.1.200 -p 10022

root@3ad7182aa47f:~#
```

## 使用Dockerfile创建
使用Dockerfile来创建一个支持SSH服务的镜像。

### 1.创建工作目录

首先，创建一个sshd_ubuntu工作目录：
```
$ mkdir sshd_ubuntu
```
在其中，创建Dockerfile和run.sh文件：
```
$ cd sshd_ubuntu/

$ touch Dockerfile run.sh
```
### 2.编写run.sh脚本和authorized_keys文件

脚本文件run.sh的内容：
```
#!/bin/bash
/usr/sbin/sshd -D
```
在宿主主机上生成SSH密钥对，并创建authorized_keys文件：
```
$ ssh-keygen -t rsa

$ cat ~/.ssh/id_rsa.pub > authorized_keys
```
### 3.编写Dockerfile

下面是Dockerfile的内容及各部分的注释，可以对比上一节中利用docker commit命令创建镜像过程，所进行的操作基本一致：

```
#设置继承镜像
FROM ubuntu:14.04
#提供一些作者的信息
MAINTAINER docker_user (user@docker.com)
#下面开始运行更新命令
RUN apt-get update
#安装ssh服务
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
#取消pam限制
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required pam_loginuid.so/g' /etc/pam.d/sshd
#复制配置文件到相应位置,并赋予脚本可执行权限
ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
RUN chmod 755 /run.sh
#开放端口
EXPOSE 22
#设置自启动命令
CMD ["/run.sh"]
```

### 4.创建镜像

在sshd_ubuntu目录下，使用docker build命令来创建镜像。这里需要注意最后还有一个“.”，表示使用当前目录中的Dockerfile：
```
$ cd sshd_ubuntu

$ docker build -t sshd:Dockerfile .
```

使用Dockerfile创建自定义镜像，需要注意的是Docker会自动删除中间临时创建的层，还需要注意每一步的操作和编写的Dockerfile中命令的对应关系。

命令执行完毕后，如果见“Successfully built XXX”字样，则说明镜像创建成功。可以看到，以上命令生成的镜像ID是570c26a9de68。

在本地查看sshd: Dockerfile镜像已存在：
```
$ docker images

REPOSITORY      TAG             IMAGE ID         CREATED           VIRTUAL SIZE

sshd            Dockerfile      570c26a9de68     4 minutes ago     246.5 MB

ubuntu          14.04           ba5877dc9bec     3 months ago      192.7 MB
```

### 5.测试镜像，运行容器

使用刚才创建的sshd: Dockerfile镜像来运行一个容器。

直接启动镜像，映射容器的22端口到本地的10122端口：
```
$ docker run -d -p 10122:22 sshd:Dockerfile

890c04ff8d769b604386ba4475253ae8c21fc92d60083759afa77573bf4e8af1

$ docker ps
```

在宿主主机新打开一个终端，连接到新建的容器：
```
$ ssh 192.168.1.200 -p 10122

root@890c04ff8d76:~#
```
效果与上一小节一致，镜像创建成功。