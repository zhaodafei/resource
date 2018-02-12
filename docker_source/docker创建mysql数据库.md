

```
docker run -d --name my-mysql -p 3306:3306 -v /home/vagrant/data/mysqlData/:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql

# 或者

docker run -it -p 3306:3306 -v /home/vagrant/data/mysqlData/:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql /bin/bash
```
防止生成数据库卡死



