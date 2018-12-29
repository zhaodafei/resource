apache 安装
1)官方地址: http://httpd.apache.org/docs/2.4/install.html
安装Apache 必须的源码包: [Apache, Apr,Apr-Util,Pcre],并且确认系统中已经安装了[gcc,gcc-c++,make,autoconf,automake],

2)centos系统中可以:

```
yum install -y gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libpng libpng-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses curl openssl-devel gdbm-devel db4-devel libXpm-devel libX11-devel gd-devel gmp-devel readline-devel libxslt-devel expat-devel xmlrpc-c xmlrpc-c-devel
```

3),下载好源码

```
wget  https://mirrors.tuna.tsinghua.edu.cn/apache//httpd/httpd-2.4.37.tar.gz
wget  https://mirrors.cnnic.cn/apache//apr/apr-1.6.5.tar.gz
wget  http://mirror.bit.edu.cn/apache//apr/apr-util-1.6.1.tar.gz
wget http://jaist.dl.sourceforge.net/project/pcre/pcre/8.36/pcre-8.36.tar.gz
```

4).安装

```
#安装过程中缺少依赖自行安装,我的pcre已经用apt安装好了
#groupadd deployer useradd -g apache apache 
#tar -zxvf apr-1.6.5.tar.gz -C /data/server/apache_component
#tar -zxvf apr-util-1.6.1.tar.gz -C /data/server/apache_component
#tar -zxvf pcre-8.36.tar.gz -C /data/server/apache_component
#tar -zxvf httpd-2.4.37.tar.gz -C /data/server/apache_component


tar -zxvf apr-1.6.5.tar.gz
cd apr-1.6.5
./configure --prefix=/data/server/apache_component/apr-1.6.5
make
make install

tar -zxvf apr-util-1.6.1.tar.gz
cd apr-util-1.6.1
./configure \
--prefix=/data/server/apache_component/apr-util-1.6.1  \
--with-apr=/data/server/apache_component/apr-1.6.5
make
make install

##centos中少库 expat-devel
##ubuntu中缺少 apt-get install libexpat-dev

tar -zxvf httpd-2.4.37.tar.gz
cd httpd-2.4.37
./configure \
--prefix=/data/server/apache \
--with-apr=/data/server/apache_component/apr-1.6.5 \
--with-apr-util=/data/server/apache_component/apr-util-1.6.1
make 
make install

##到这里已经安装完毕,下面配置Apache

vim httpd.conf   #修改配置
ServerName www.test.com:80

##Apache常用命令
/data/server/apache/bin/apachectl -v   #查看Apache版本
/data/server/apache/bin/apachectl start
/data/server/apache/bin/apachectl restart

```

### Apache 解析php

```
#方法一: PHP编译的时候使用--with-apxs2
'--with-apxs2=/usr/local/apache/bin/apxs' #让Apache支持PHP
#查看原来PHP的编译参数
/data/server/php7/bin/php -i | grep  configure

#方法二,在Apache2.4以后支持FCGI方式
在Apache的conf中添加自己的文件路径;  Include conf/self_vhosts/*.conf

<VirtualHost *:80>
  #ServerAdmin webmaster@localhost
  ServerName www.afei.com
  DocumentRoot /data/www
  
  #主要是这2个配置
  ProxyRequests Off
  ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000/data/www/$1

  <Directory /data/www>
     Options FollowSymlinks
     DirectoryIndex index.php
     AllowOverride All
     Require all granted
  </Directory>
</VirtualHost>

##需要在 conf/httpd.conf 文件中打开4个扩展,把下面这几个的注释都打开
#LoadModule proxy_module modules/mod_proxy.so
#LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so
#LoadModule rewrite_module modules/mod_rewrite.so
#LoadModule proxy_http_module modules/mod_proxy_http.so  
```

