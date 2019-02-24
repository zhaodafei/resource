---
title: centos7 中安装composer
---

```
####  安装composer  运行项目  ,我的PHP是编译安装没设置环境变量
curl -sS https://getcomposer.org/installer | /data/server/php/bin/php
mv composer.phar /usr/local/bin/composer

composer -v可以看到composer信息,如果提示php 找不到,需要配置php环境变量
#centos中配置PHP环境变量:
修改 /etc/profile 配置环境变量
PATH=$PATH:/data/server/php/bin
export PATH
然后执行source /etc/profile 或者 ./profile 使其生效; 执行完后可以通过 echo $PATH  命令查看环境变量

###PATH=$PATH:/data/server/php/bin  意思加入环境变量
###export PATH          意思使环境变量生效
###centos中安装composer 不能使用root用户操作,需要使用其他用户
```

### composer 常用命令

```
composer config -gl    #查看composer全局设置
composer config --list -g  #查看composer全局设置
composer require monolog/monolog   #安装monolog
composer require monolog/monolog:"1.24.0"   #安装monolog指定版本
composer require "monolog/monolog:1.24.0"   #安装monolog指定版本
composer install 
composer update
composer dump-autoload   #添加自定义后文件执行

设置镜像地址:
1) 全局配置
composer config -g repo.packagist composer https://repo.packagist.org
2) 当前项目使用  [ 去掉参数-g ]
 composer config repo.packagist composer https://repo.packagist.org

repo.packagist.org  ip地址: 139.99.121.122   新加坡
packagist.org       ip地址: 139.99.121.122   新加坡

其他镜像地址
composer-proxy.jp  
packagist.jp
https://packagist.laravel-china.org  [laravel 中国镜像]
```



[composer官方安装文档](https://docs.phpcomposer.com/00-intro.html#Installation-*nix)

[packagist仓库地址]: https://repo.packagist.org/	"packagist仓库地址"
[packagist仓库地址]: https://packagist.org/	"packagist仓库地址"





