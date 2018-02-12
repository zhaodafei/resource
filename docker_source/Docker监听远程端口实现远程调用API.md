https://www.58jb.com/html/101.html

```
Centos7

Docker 1.12.0  的配置方法：

查找Docker包：

[root@test ~]# rpm -qa|grep docker 
 
docker-engine-selinux-1.12.0-1.el7.centos.noarch 
 
docker-engine-1.12.0-1.el7.centos.x86_64 
 
docker-registry-0.9.1-7.el7.x86_64 

查看docker-engine-1.12.0-1.el7.centos.x86_64的安装目录：【yum安装的都是一样的位置】


rpm -ql docker-engine-1.12.0-1.el7.centos.x86_64 

vim /lib/systemd/system/docker.service

ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock 

端口可根据情况修改，不冲突就好；

重启Docker程序：

systemctl daemon-reload 

systemctl restart docker 

```


```
系统：Centos6.5 

Docker 1.7.1配置方法：

修改配置文件：/etc/sysconfig/docker

添加以下参数：

other_args="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"

保存，重启Docker程序；

测试方法：

通过接口获取所有的镜像:

curl 'http://192.168.18.54:2375/images/json?all=0'| python -m json.tool 
查看已经启动的容器信息：

curl http://192.168.18.54:2375/containers/json |python -m json.tool 
获取指定容器的具体信息：

curl -X GET 'http://192.168.18.54:2375/containers/e37e50e73bd4/json'|python -m json.tool 
启动指定容器：【此处使用容器别名】

curl -XPOST "http://192.168.18.54:2375/containers/t1/start" 

```



参考链接：https://www.ivankrizsan.se/2016/05/18/enabling-docker-remote-api-on-ubuntu-16-04/

在Ubuntu 16.04中运行Docker时，我试图找到有关如何启用Docker远程API的说明，但是我遇到的任何指示都无法让我一路走来，所以这里有一些关于我如何设法完成这个的简短说明：

编辑文件/lib/systemd/system/docker.service 

```
sudo vim /lib/systemd/system/docker.service
```

修改以ExecStart开头的行如下所示：

```
ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:4243


# 这个没测试
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock

ExecStart=/usr/bin/docker daemon -H=fd:// -H=tcp://0.0.0.0:2375
```

我的添加是“-H tcp：//0.0.0.0：4243”的部分。
保存修改后的文件。
确保Docker服务注意到修改的配置：

```
sudo systemctl daemon-reload
```

重新启动Docker服务：

```
sudo service docker restart

sudo systemctl restart docker
```

测试Docker API确实可访问：

```
curl http://localhost:4243/version
```

您应该看到与此相似的输出结果：

```
{"Version":"17.05.0-ce","ApiVersion":"1.29","MinAPIVersion":"1.12","GitCommit":"89658be","GoVersion":"go1.7.5","Os":"linux","Arch":"amd64","KernelVersion":"4.4.0-83-generic","BuildTime":"2017-05-04T22:10:54.638119411+00:00"}
```

要从另一台计算机访问Docker API，请使用在wlan0或eth0上找到的Ubuntu计算机的IP地址，具体取决于您是使用wifi还是以太网网络连接。
要了解不同接口的IP地址，请在终端窗口中使用ifconfig命令。在我的情况下是192.168.1.88。


其他方式：


https://docs.lvrui.io/2017/02/19/docker-socket%E8%AE%BE%E7%BD%AE/



```
1 修改配置文件
CentOS6:

/etc/sysconfig/docker

添加一行: DOCKER_OPTS='-H tcp://0.0.0.0:2375  -H unix:///var/run/docker.sock'

CentOS7: 

/usr/lib/systemd/system/docker.service

修改一行:
ExecStart=/usr/bin/dockerd  -H tcp://0.0.0.0:2375  -H unix:///var/run/docker.sock
 
2. 重启Docker

CentOS6: 

service docker restart 

CentOS7:   

systemctl daemon-reload

systemctl restart docker.service 

3. 测试在本机

curl http://127.0.0.1:2375/info

在其他机器上：curl http://hostanme:2375/info

此时本地client可以继续通过Unix sock与docker daemon通行

例如：docker info 命令继续有效。


```