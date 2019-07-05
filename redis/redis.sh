#!bin/bash
#redis 一键安装脚本
mkdir -p  /data/server /data/www
cd /data/server/
wget http://download.redis.io/releases/redis-4.0.8.tar.gz
tar -xzvf redis-4.0.8.tar.gz  -C /data/server/
cd /data/server/redis-4.0.8/
make

cp -avr /data/server/redis-4.0.8/redis.conf  /data/server/redis-4.0.8/redis.conf.backups
sed -i 's/^bind 127.0.0.1$/#bind 127.0.0.1/' /data/server/redis-4.0.8/redis.conf
sed -i 's/^# requirepass foobared$/requirepass redis_pwd_123456/' /data/server/redis-4.0.8/redis.conf
sed -i 's/^daemonize no$/daemonize yes/' /data/server/redis-4.0.8/redis.conf
/data/server/redis-4.0.8/src/redis-server /data/server/redis-4.0.8/redis.conf
ps -aux | grep redis
