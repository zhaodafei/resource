## 获取镜像
```
docker pull [选项] [Docker Registry地址]<仓库名>:<标签>

# 下载ubuntu14.04
docker pull ubuntu:14.04

# 下载最新的ubuntu
docker pull ubuntu

# 从网易蜂巢下载ubuntu
docker pull hub.c.163.com/public/ubuntu:14.04

```


## 查看镜像信息
```
docker images
```

## 添加镜像标签
```
docker tag ubuntu:16.04 myubuntu:16.04
```

## 查看镜像的详细信息
```
docker inspect ubuntu:14.04

# 查看其中一项
docker inspect -f {{".Config.Cmd"}} ubuntu:14.04
```

## 查看镜像历史
```
docker history ubuntu:14.04
```

## 搜寻镜像
```
docker search --automated -s 3 nginx

docker search ubuntu:16.04
```

## 删除镜像
```
docker rmi [选项] <镜像1> [<镜像2> ...]

docker rmi myubuntu:16.04

# 指定id
docker rmi d5127813070b

# 删除所有虚悬镜像
docker rmi $(docker images -q -f dangling=true)

# 删除所有仓库名包含 redis 的镜像
docker rmi $(docker images -q redis)
```

## 创建镜像
### 1. 基于已有镜像的容器创建
```
# fa 是容器的id，容器名称也可以
docker commit -m "add index.php" -a "luointo" fa test:0.1
```
* -m : 提交信息
* -a ：作者信息
* -p ：提交时暂停容器运行


### 2. 基于本地模板导入
```
docker import 
```

## 导出和载入镜像

### 1. 导出镜像
> 导出有两种命令可以实现：save和export
export 导出的是容器当用所用的镜像内容
save 保存的是所有这个镜像的版本记录，包括一些历史数据.
```
docker save -o ubuntu_14.04.tar ubuntu:14.04

docker export 6c5563 > ./ubuntu_tomcat.tar.gz
```
### 2. 载入镜像
```
docker load --input ubuntu_14.04.tar
或者
docker load < ubuntu_14.04.tar
```

## 上传镜像
```
docker push user/test:latest
```
