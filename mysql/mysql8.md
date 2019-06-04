---
title: mysql 8.0.12
---

```shell
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

```shell
#使用mysql
sudo groupadd mysql
sudo useradd -r -g mysql -s /bin/false mysql

cd /data/server/mysql
sudo chown -R mysql .
sudo chgrp -R mysql .

##!!!! 初始化加参数 --default-authentication-plugin=mysql_native_password
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
 ALTER USER 'username'@'host' IDENTIFIED WITH mysql_native_password  BY 'new_password';#修改加密方式
-----
 create user 'vagrant'@'%' identified by '123456';
 grant all privileges on *.* to 'vagrant'@'%';
 
 #这时候问题来了,mysql使用的加密方式是caching_sha2_password ,之前的版本是mysql_native_password 好多客户端连接不上,修改用户的加密方式
 ALTER USER 'vagrant'@'%' IDENTIFIED WITH mysql_native_password  BY '123456';
```

```mysql
SHOW VARIABLES LIKE 'default_authentication_plugin'
##SET GLOBAL default_authentication_plugin=mysql_native_password;  #提示变量只读.....

#采用修改 my.cnf(linux) my.ini(windows) 配置文件方式
default_authentication_plugin=mysql_native_password
#现在新建的用户密码使用 mysql_native_password 加密方式
ALTER USER 'username'@'host' IDENTIFIED WITH mysql_native_password  BY 'new_password';#修改加密方式


-_- mysql 官王说PHP 的mysql_xdevapi 扩展可以连接新的mysql加密方式,但是php官方还没有出使用方法 -_-
```

 [MySQL 8.0的密码变化](<https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html#upgrade-caching-sha2-password> "MySQL 8.0的密码变化")