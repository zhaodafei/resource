## 移除所有的容器和镜像（大扫除）
```
 docker kill $(docker ps -q) ; docker rm $(docker ps -a -q) ; docker rmi $(docker images -q -a)
```

> 注：shell 中的 $() 和 `` 类似，会先执行这里面的内容，上面的脚本会出现如下 docker kill "pids" ; docker kill 在 docker 中用于停止容器，docker rm 删除容器， docker rmi 删除镜像

> 可以使用 docker rm $(docker ps -q -a) 一次性删除所有的容器，docker rmi $(docker images -q) 一次性删除所有的镜像。

## 退出时删除容器
```
docker run --rm -i -t busybox /bin/bash
```


