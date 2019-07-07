#!bin/bash
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::                                                                          ::"
echo "::      欢迎使用linux 一键编译安装redis-4.0.8                                 ::"
echo "::      本脚本由  ☆赵大飞☆  编写，如有疑问请联系本人！                       ::"
echo "::      转载请不要删除本信息！      1097625354@qq.com                        ::"
echo "::                                                                          ::"
echo "::                                                                          ::"
echo "::      作者：☆赵大飞☆        QQ:1097625354                                ::"
echo "::                                                                          ::"
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
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


wget -P /data/download/ http://download.redis.io/releases/redis-4.0.8.tar.gz
cd /data/download/
tar -xzvf redis-4.0.8.tar.gz  -C /data/server/
cd /data/server/redis-4.0.8/
make

cp -avr /data/server/redis-4.0.8/redis.conf  /data/server/redis-4.0.8/redis.conf.backups
sed -i 's/^bind 127.0.0.1$/#bind 127.0.0.1/' /data/server/redis-4.0.8/redis.conf
sed -i 's/^# requirepass foobared$/requirepass redis_pwd_123456/' /data/server/redis-4.0.8/redis.conf
sed -i 's/^daemonize no$/daemonize yes/' /data/server/redis-4.0.8/redis.conf
/data/server/redis-4.0.8/src/redis-server /data/server/redis-4.0.8/redis.conf
ps -aux | grep redis
