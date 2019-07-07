#!bin/bash

echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::                                                                          ::"
echo "::      欢迎使用linux 一键编译安装Nginx1.4.2                                 ::"
echo "::      本脚本由  ☆赵大飞☆  编写，如有疑问请联系本人！                      ::"
echo "::      转载请不要删除本信息！      1097625354@qq.com                        ::"
echo "::                                                                          ::"
echo "::                                                                          ::"
echo "::      作者：☆赵大飞☆        QQ:1097625354                                ::"
echo "::                                                                          ::"
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
echo "请选择你要的操作"
echo "     1、ubuntu16 创建基础目录 /data/download /data/oneKey  /data/server /data/www"
echo "     2、centos7 创建基础目录 /data/download /data/oneKey  /data/server /data/www"
echo "     3、跳过"
echo ""
read num
case "$num" in
	[1] )
		mkdir -p  /data/download /data/oneKey  /data/server /data/www
		;;
	[2] )
		mkdir -p  /data/download /data/oneKey  /data/server /data/www
		;;
	[3] )
		echo "跳过"
		;;
		*) echo "选择错误，退出";;
esac
echo ""
echo ""
echo " 请选择你要的操作："
echo "     1、ubuntu16 安装开发类库 build-essential apt-get install libtool apt-get install g++"
echo "     2、centos7 安装开发类库 gcc automake autoconf libtool make gcc gcc-c++"
echo "     3、跳过"
echo ""
read num
case "$num" in
	[1] )
		sudo apt-get install build-essential apt-get install libtool apt-get install g++
		;;
	[2] )
		yum -y install gcc automake autoconf libtool make gcc gcc-c++
		;;
	[3] )
		echo "跳过"
		;;
		*) echo "选择错误，退出";;
esac

echo ""
echo ""
echo " 请选择你要的操作："
echo "     1、ubuntu16 nginx 依赖安装 libpcre3 libpcre3-dev openssl libssl-dev zlib1g-dev"
echo "     2、centos7 nginx  依赖安装 pcre pcre-devel  openssl openssl-devel  zlib zlib-devel "
echo "     3、跳过"
echo ""
read num
case "$num" in
	[1] )
		sudo apt-get install libpcre3 libpcre3-dev openssl libssl-dev zlib1g-dev
		;;
	[2] )
		yum -y install pcre pcre-devel  openssl openssl-devel  zlib zlib-devel
		;;
	[3] )
		echo "跳过"
		;;
		*) echo "选择错误，退出";;
esac

wget -P /data/download/ http://nginx.org/download/nginx-1.14.1.tar.gz
cd /data/download/
tar -zxvf nginx-1.14.1.tar.gz
cd nginx-1.14.1
./configure --prefix=/data/server/nginx
make && make install
/data/server/nginx/sbin/nginx -t

