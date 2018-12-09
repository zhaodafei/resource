---
title: mysql 8.0.12
---

```
#内存大于2G,硬盘空间大于10G

wget http://ftp.ntu.edu.tw/MySQL/Downloads/MySQL-8.0/mysql-boost-8.0.12.tar.gz

tar zxvf mysql-boost-8.0.12.tar.gz

sudo apt install make cmake gcc g++ perl bison libaio-dev libncurses5 libncurses5-dev libnuma-dev

### 注意看提示,可能好依赖,安装对应的依赖[mysql8 ,虚拟机10G 内存不够用]
cmake . -DBUILD_CONFIG=mysql_release \
-DCPACK_MONOLITHIC_INSTALL=ON \
-DCMAKE_INSTALL_PREFIX=/data/server/mysql \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DMYSQL_UNIX_ADDR=/data/server/mysql/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DMYSQLX_UNIX_ADDR=/data/server/mysql/mysqlx.sock \
-DMYSQL_DATADIR=/data/server/mysql/data \
-DSYSCONFDIR=/data/server/mysql/etc \
-DWITH_BOOST=/home/vagrant/download/mysql-8.0.12/boost/boost_1_67_0

make
make install
```

```
#使用mysql
sudo groupadd mysql
sudo useradd -r -g mysql -s /bin/false mysql

cd /data/server/mysql
sudo chown -R mysql .
sudo chgrp -R mysql .

#sudo bin/mysqld --initialize --user=mysql   #创建临时密码,注意密码保存出现的秘密
sudo bin/mysqld --initialize-insecure --user=mysql #创建空密码

#登录后重新设置密码
support-files/mysql.server start
bin/mysql -u root -p
alter user 'root'@'localhost' identified by 'new_password';
flush privileges;

#创建新用户并允许远程连接
 create user 'username'@'host' identified by 'new_password';
 grant all privileges on *.* to 'username'@'host';

-----
 create user 'vagrant'@'%' identified by '123456';
 grant all privileges on *.* to 'vagrant'@'%';
 
 
```

