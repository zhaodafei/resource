#!bin/bash
echo -e  "\x1B[35m  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \x1B[0m"
echo "::                                                                          ::"
echo "::      欢迎使用linux 一键编译安装mysql5.6.39                                ::"
echo "::      如需安装其他版本,请自行修改下载地址                                  ::"
echo "::      本脚本由  ☆赵大飞☆  编写，如有疑问请联系本人！                      ::"
echo "::      转载请不要删除本信息！      1097625354@qq.com                        ::"
echo "::                                                                          ::"
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
echo "     1、ubuntu16 安装开发类库  make cmake gcc g++ perl bison libaio-dev libncurses5 libncurses5-dev libnuma-dev"
echo ""
echo "     2、centos7 安装开发类库 gcc gcc-c++ cmake ncurses-devel autoconf perl perl-devel "
echo "     3、跳过"
echo ""
read num
case "$num" in
	1)
		sudo apt -y install make cmake gcc g++ perl bison libaio-dev libncurses5 libncurses5-dev libnuma-dev
	;;
	2)
        yum -y install gcc gcc-c++ cmake ncurses-devel autoconf perl perl-devel
	;;
	3)
		echo "跳过"
	;;
	*) echo "选择错误，退出";;
esac
echo ""
echo ""
echo " 请选择你要的操作：是否下载 mysql-5.6.39.tar.gz"
echo "     1、是"
echo "     2、否"
echo "     3、跳过"
echo ""
read num
case "$num" in
	1)
		wget -P /data/download/ https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.39.tar.gz
	;;
	2)
	    echo "开始安装mysql-5.6.39"
	;;
	3)
	    echo "开始安装mysql-5.6.39"
	;;
	*) echo "选择错误，退出";;
esac
echo ""
echo " 创建mysql用户"
if id -u $username >/dev/null 2>&1; then
        echo "user exist"
else
        #echo "user does not exist"
        sudo groupadd mysql
        sudo useradd -r -g mysql -s /bin/false mysql
fi




#wget -P /data/download/ https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.39.tar.gz
cd /data/download/
tar -zxvf mysql-5.6.39.tar.gz
cd  /data/download/mysql-5.6.39
cmake \
-DCMAKE_INSTALL_PREFIX=/data/server/mysql \
-DMYSQL_DATADIR=/data/server/mysql/data \
-DSYSCONFDIR=/data/server/mysql/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/data/server/mysql/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci

make && make install

echo ""
echo ""
echo ""
echo "数据库安装完毕,请手动初始化,修改权限"
echo "修改用户权限  mysql:mysql 和 mysql_install_db文件可执行权"
