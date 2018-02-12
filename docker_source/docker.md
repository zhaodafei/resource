## Docker官网

https://www.docker.com

## Docker镜像仓库

* docker官方仓库 https://store.docker.com

* 网易 https://c.163.com/hub#/m/home/

* DaoCloud http://hub.daocloud.io

* 阿里云 https://dev.aliyun.com/search.html


Docker 中文文档：http://www.dockerinfo.net/document

Docker 教程：http://www.runoob.com/docker/docker-tutorial.html



## Docker安装

官方安装文档：https://docs.docker.com/engine/installation/

### 脚本安装

* 阿里云 https://cr.console.aliyun.com/?spm=5176.1971733.0.2.394b9fbdMHqEfB#/accelerator

* DaoCloud http://guide.daocloud.io/dcs/docker-9152677.html

```
# 官方（由于墙的原因，速度缓慢）
curl -sSL https://get.docker.com/ | sh

# 阿里云的安装脚本
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -

# DaoCloud 的安装脚本
curl -sSL https://get.daocloud.io/docker | sh 
```

## debian系列手动安装

参考文档：

https://yeasy.gitbooks.io/docker_practice/content/install/ubuntu.html

http://www.dockerinfo.net/1461.html

```
# 为了确认所下载软件包的合法性，需要添加 Docker 官方软件源的 GPG 密钥

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D


echo deb https://apt.dockerproject.org/repo debian-stretch main | sudo tee -a /etc/apt/sources.list

sudo apt-get update

sudo apt-get install docker-engine

```


## Docker安装后配置

>普通用户，加入docker用户组，去掉sudo，设置开机启动docker

```
# 查看docker组是否存在
sudo cat /etc/group | grep docker

# 如果不存在docker组，可以添加
sudo groupadd docker

# 将您的用户添加到docker组中
sudo usermod -aG docker $USER （sudo gpasswd -a ${USER} docker）

# 重启docker服务
sudo systemctl restart docker（ sudo service docker restart ）

# 如果权限不够
sudo chmod a+rw /var/run/docker.sock

# 配置Docker开机启动
sudo systemctl enable docker
```

## docker例子

https://docs.docker.com/compose/django/

## 安装docker-machine

github地址：https://github.com/docker/machine/releases

```
chmod +x docker-machine-Linux-x86_64

sudo cp -p docker-machine-Linux-x86_64 /usr/local/bin/docker-machine
```


## 安装docker-compose

github地址：https://github.com/docker/compose/releases

文档：https://docs.docker.com/compose/overview/

```
# 下载run.sh文件

# 运行
sh run.sh

# 创建快捷方式
sudo cp -p run.sh /usr/local/bin/docker-compose

如果报错重启系统

```
