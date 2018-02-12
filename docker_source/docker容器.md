[TOC]
## 参数

```
-i: 以交互模式运行容器，通常与 -t 同时使用； 
-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用 
–name=”nginx-lb”: 为容器指定一个名称； 
-P 将容器的80端口映射到主机随机端口。 
-p 80:80 将容器的80端口映射到主机的80端口 
-v 映射主机目录和容器目录
```

## 创建容器
### 1. 新建容器
```
docker create -it ubuntu:latest
```

### 2. 启动容器
```
docker start 2833f2a0b1b7
```

### 3. 新建并启动容器
```
docker run -it ubuntu:14.04 /bin/bash
```

## 终止容器
```
docker stop 28
```

## 进入容器
```
docker exec -it 2833 /bin/bash
```

## 删除容器
```
docker rm fa

-f 强行终止并删除
-l 删除容器的连接，但保留容器
-v 删除容器挂载的数据卷

docker rm -f 33
```

## 导入和到处容器

### 1. 导出容器
```
docker export -o test.tar 5de

docker export 43ba > test2.tar
```

### 2. 导入容器
```
docker import test.tar  test/ubuntu:1.0
```


## 如何在docker容器和宿主机之间复制文件

### 从主机复制到容器

```
# docker cp 要拷贝的文件路径 容器名：要拷贝到容器里面对应的路径

sudo docker cp host_path containerID:container_path

```


### 从容器复制到主机

```
# docker cp 容器名：要拷贝的文件在容器里面的路径 要拷贝到宿主机的相应路径

sudo docker cp containerID:container_path host_path
```


```
# 输出一个“hello world”后终止容器
$ docker run ubuntu:16.04 /bin/echo 'hello world'
hello world

# 启动一个 bash 终端，允许用户进行交互
$ docker run -it ubuntu:16.04 /bin/bash 
root@0eb917598209:/# exit 
exit
$

# 后台运行，主要使用 -d 参数
$ docker run -d ubuntu:16.04 /bin

# 查看运行中的容器
$ docker ps

# 查看所有容器
$ docker ps -a

# 进入容器
# 方法一：attach 此方法会受命令阻塞影响，并且 exit 退出后将同时关闭容器
$ docker attach <容器id>
# 方法二：exec（推荐）
$ docker exec -it $CONTAINER_ID /bin/bash

# 关闭容器
$ docker stop $CONTAINER_ID

# 启动已关闭的容器
$ docker start $CONTAINER_ID

# 获取容器的输出信息
$ docker logs $CONTAINER_ID

# 查看容器的相关信息
$ docker inspect $CONTAINER_ID

# 删除容器
$ docker rm $CONTAINER_ID-1 $CONTAINER_ID-2 $CONTAINER_ID-3 ...

# 删除所有未运行的容器
$ docker rm $(docker ps -a -q)

# 导出容器
$ docker export $CONTAINER_ID > 导出文件名.tar

# 导入容器
# 方法一：import，导入容器快照
$ cat 导出文件名.tar | sudo docker import - 导入镜像名称:标签
# 方法二：load，导入镜像存储文件
$ docker load 导出文件名.tar
```