http://www.tanhui.bid/docker/2016/10/19/使用Docker-docker-compose-搭建nginx+php+mysql-环境
[TOC]

## mysql

```
docker run -d --name lnmp-mysql -p 3306:3306 -v /home/vagrant/data/lnmp/mysqldata/:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql

# 命令说明

-p 3306:3306 将容器的3306端口映射到主机的3306端口

-v /home/vagrant/data/lnmp/mysqldata/:/var/lib/mysql 将主机的mysqldata文件夹挂载到容器的/var/lib/mysql 下，在mysql容器中产生的数据就会保存在本机mysqldata目录下

-e MYSQL_ROOT_PASSWORD=root 初始化root用户的密码为root

-d 后台运行容器

--name 给容器指定别名

# 进入容器
docker exec -it lnmp-mysql /bin/bash
```

## php

Dockerfile文件

```
FROM  php:5.6-fpm
RUN apt-get update && apt-get install -y \
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng12-dev \
vim \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install gd \

```

build新的镜像

```
docker build -t lnmp-php-fpm5.6:v1 .
```

然后用这个镜像跑一个php环境的容器

```
docker run -d --name lnmp-php -p 9000:9000 -v /home/vagrant/data/lnmp/code/:/var/www/html --link lnmp-mysql:mysql --volumes-from lnmp-mysql lnmp-php-fpm5.6:v1

# 命令说明

－v 将本地磁盘上的php代码挂载到docker 环境中，对应docker的目录是 /var/www/html/

--name 新建的容器名称 lnmp-php

--link 链接的容器，链接的容器名称：在该容器中的别名，运行这个容器是，docker中会自动添加一个host识别被链接的容器ip

--volumes-from lnmp-mysql 将lnmp-mysql 容器挂载的文件也同样挂载到nginx容器中

# 进入容器
docker exec -it lnmp-php /bin/bash
```

## nginx

```/home/vagrant/data/lnmp/nginx/conf/default.conf``` 文件

```
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /var/www/html;
        index  index.html index.htm index.php; # 增加index.php
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /var/www/html;
    }
    location ~ \.php$ {
        root           /var/www/html; # 代码目录
        fastcgi_pass   lnmp-php:9000;    # 修改为lnmp-php容器
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name; # 修改为$document_root
        include        fastcgi_params;
    }
}

```

```
docker run -d --name lnmp-nginx -p 80:80 --link lnmp-php:phpfpm --volumes-from lnmp-php -v /home/vagrant/data/lnmp/nginx/conf/default.conf:/etc/nginx/conf.d/default.conf nginx

docker exec -it lnmp-nginx /bin/bash

# 参数解析

--link lnmp-php:phpfpm 将php容器链接到nginx容器里来，phpfpm是nginx容器里的别名

--volumes-from lnmp-php 将lnmp-php容器挂载的文件也同样挂载到nginx容器中

-v /home/vagrant/data/lnmp/nginx/conf/default.conf:/etc/nginx/conf.d/default.conf 将nginx 的配置文件替换，挂载本地编写的配置文件

```


## docker-compose安装

docker-compose.yml 文件

```
nginx:
  build: ./nginx
  ports:
    - "80:80"
  links:
    - "phpfpm"
  volumes:
    - /home/vagrant/data/compose-lnmp/code/:/var/www/html/
    - /home/vagrant/data/compose-lnmp/nginx/conf/default.conf:/etc/nginx/conf.d/default.conf
phpfpm:
  build: ./phpfpm
  ports:
    - "9000:9000"
  volumes:
    - ./code/:/var/www/html/
  links:
    - "mysql"
mysql:
  build: ./mysql
  ports:
    - "3306:3306"
  volumes:
    - /home/vagrant/data/compose-lnmp/mysql/data/:/var/lib/mysql/
  environment:
    MYSQL_ROOT_PASSWORD : root

```

目录结构：

```
[vagrant@centos7 data]$ tree compose-lnmp/                                                          
compose-lnmp/                                                                                       
├── code                                                                                            
│   └── index.php                                                                                   
├── docker-compose.yml                                                                              
├── mysql                                                                                           
│   ├── data                                                                                        
│   │   ├── aaa                                                                                     
│   │   │   └── db.opt                                                                              
│   │   ├── auto.cnf                                                                                
│   │   ├── ibdata1                                                                                 
│   │   ├── ib_logfile0                                                                             
│   │   ├── ib_logfile1                                                                             
│   │   ├── mysql                                                                                   
│   │   │   ├── columns_priv.frm                                                                    
│   │   │   ├── columns_priv.MYD                                                                                                                                                         
│   │   │   ├── user.frm                                                                            
│   │   │   ├── user.MYD                                                                            
│   │   │   └── user.MYI                                                                            
│   │   └── performance_schema                                                                      
│   │       ├── accounts.frm                                                                        
│   │       ├── cond_instances.frm                                                                                                               
│   │       ├── table_lock_waits_summary_by_table.frm                                               
│   │       ├── threads.frm                                                                         
│   │       └── users.frm                                                                           
│   └── Dockerfile                                                                                  
├── nginx                                                                                           
│   ├── conf                                                                                        
│   │   └── default.conf                                                                            
│   └── Dockerfile                                                                                  
└── phpfpm                                                                                          
    └── Dockerfile                                                                                  
```

运行：

```
docker-compose up -d
```