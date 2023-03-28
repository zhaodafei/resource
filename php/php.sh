#!bin/bash
echo -e  "\x1B[35m  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \x1B[0m"
echo "::                                                                          ::"
echo "::      欢迎使用linux 一键编译安装php-7.0.28                                 ::"
echo "::      如需安装其他版本,请自行修改下载地址                                  ::"
echo "::      本脚本由  ☆赵大飞☆  编写，如有疑问请联系本人！                      ::"
echo "::      转载请不要删除本信息！      1097625354@qq.com                        ::"
echo "::                                                                          ::"
echo "::      安装过程中注意看报错信息,不同的系统缺少的包不一样,自行安装             ::"
echo "::                                                                          ::"
echo "::      作者：☆赵大飞☆        QQ:1097625354                                ::"
echo "::                                                                          ::"
echo -e  "\x1B[35m  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \x1B[0m"
echo ""
echo "请选择你要的操作"
echo "     1、ubuntu16 创建基础目录 /data/download /data/oneKey  /data/server /data/www"
echo "     2、centos7 创建基础目录 /data/download /data/oneKey  /data/server /data/www"
echo "     3、跳过"
echo ""
read num
case "$num" in
	1)
		mkdir -p  /data/download /data/oneKey  /data/server /data/www
	;;
	2)
		mkdir -p  /data/download /data/oneKey  /data/server /data/www
	;;
	3)
		echo "跳过"
	;;
	*) echo "选择错误，退出";;
esac
echo ""
echo ""
echo " 请选择你要的操作："
echo "     1、ubuntu16 安装开发类库  libxml2-dev build-essential openssl libssl-dev make"
echo "                              curl libcurl4-gnutls-dev libjpeg-dev libpng-dev libmcrypt-dev"
echo "                              libreadline6 libreadline6-dev libfreetype6-dev libxslt1-dev"
echo ""
echo "     2、centos7 安装开发类库 epel-release libxml2 libxml2-devel  libjpeg-devel libpng-devel  libmcrypt  libmcrypt-devel "
echo "                             curl-devel freetype-devel openssl openssl-devel  libxslt libxslt-devel"
echo "     3、跳过"
echo ""
read num
case "$num" in
	1)
		sudo apt-get -y install libxml2-dev build-essential openssl libssl-dev make
		sudo apt-get -y install url libcurl4-gnutls-dev libjpeg-dev libpng-dev libmcrypt-dev
		sudo apt-get -y install libreadline6 libreadline6-dev libfreetype6-dev libxslt1-dev
	;;
	2)
	  yum install -y epel-release
	  yum -y install libxslt libxslt-devel
		yum -y install ibxml2 libxml2-devel curl-devel libjpeg-devel libpng-devel freetype-devel  libmcrypt-devel openssl openssl-devel
	;;
	3)
		echo "跳过"
	;;
	*) echo "选择错误，退出";;
esac
echo ""
echo ""
echo " 请选择你要的操作：是否下载 php-7.0.28.tar.gz"
echo "     1、是"
echo "     2、否"
echo "     3、跳过"
echo ""
read num
case "$num" in
	1)
		wget -P /data/download/ http://cn2.php.net/get/php-7.0.28.tar.gz/from/this/mirror
	;;
	2)
	    echo "开始安装php-7.0.28"
	;;
	3)
	    echo "开始安装php-7.0.28"
	;;
	*) echo "选择错误，退出";;
esac

#wget -P /data/download/ http://cn2.php.net/get/php-7.0.28.tar.gz/from/this/mirror
cd /data/download/
mv mirror php-7.0.28.tar.gz
tar -zxvf php-7.0.28.tar.gz
cd /data/download/php-7.0.28
./configure --prefix=/data/server/php70 \
 --with-curl \
 --with-freetype-dir \
 --with-gd \
 --with-gettext \
 --with-iconv-dir \
 --with-kerberos \
 --with-libdir=lib64 \
 --with-libxml-dir \
 --with-mysqli \
 --with-openssl \
 --with-pcre-regex \
 --with-pdo-mysql \
 --with-pdo-sqlite \
 --with-pear \
 --with-png-dir \
 --with-xmlrpc \
 --with-xsl \
 --with-zlib \
 --enable-fpm \
 --enable-bcmath \
 --enable-libxml \
 --enable-inline-optimization \
 --enable-gd-native-ttf \
 --enable-mbregex \
 --enable-mbstring \
 --enable-opcache \
 --enable-pcntl \
 --enable-shmop \
 --enable-soap \
 --enable-sockets \
 --enable-sysvsem \
 --enable-xml \
 --enable-zip \
 --enable-mysqlnd \
 --with-pdo-mysql=mysqlnd \
 --with-mcrypt

make &&  make install

echo ""
echo ""
cp /data/download/php-7.0.28/php.ini-development   /data/server/php70/lib/php.ini
cp /data/server/php70/etc/php-fpm.conf.default /data/server/php70/etc/php-fpm.conf
cp /data/server/php70/etc/php-fpm.d/www.conf.default /data/server/php70/etc/php-fpm.d/www.conf
/data/server/php70/bin/php -v

