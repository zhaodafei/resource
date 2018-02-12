## 数据卷

### 1. 在容器内部创建一个数据卷
```

docker run -d -P --name web -v /webapp training/webapp python app.py
```

### 2. 挂载一个主机目录作为数据卷
```
docker run -itd --name dbdata -v d:/docker/web:/dbdata ubuntu /bin/bash

```
> 默认挂载的路径权限为读写。如果指定为只读可以用：ro
docker run -it -v /home/dock/Downloads:/usr/Downloads:ro ubuntu64 /bin/bash

## 数据卷容器
```
# 先创建数据卷容器dbdata
docker run -it -v /dbdata --name dbdata ubuntu

# 容器db1和db2挂载dbdata
docker run -it --volumes-from dbdata --name db1 ubuntu
docker run -it --volumes-from dbdata --name db2 ubuntu
```