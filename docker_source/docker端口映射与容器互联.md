## 端口映射实现访问容器

## 关键配置参数
```
-P（大写） 随机映射一个49000~49900端口

-p 80:80
```

### 1. 从外部访问容器应用
```
docker run -d -P training/webapp python app.py
```

### 2. 映射所有接口地址
```
docker run -d -p 5000:5000 -p 3000:80 training/webapp python app.py
```

### 3. 映射到指定地址的指定端口
```
docker run -d -p 127.0.0.1:5000:5000 training/webapp python app.py
```

### 4. 映射到指定地址的任意端口
```
docker run -d -p 127.0.0.1::5000 training/webapp python app.py
```

## 查看映射端口配置
```
docker port 86b6a42a645d 5000
```

## 互联
```
--link name:alias name要连接的容器名称，alias这个连接的别名

docker run -d --name db training/postgres

docker run -d -p 5000:5000 --name web --link db:db training/webapp python app.py
```