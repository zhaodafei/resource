---
title: mysql -sql other
---

### mysql 简单整理

 group by  ;  group_concat 

```
SELECT * FROM student_01 GROUP BY `name`;

SELECT *,GROUP_CONCAT(name) FROM student_01 GROUP BY `name`;

+----+------+---------+-------+
| id | name | kecheng | score |
+----+------+---------+-------+
|  1 | 张三  | 语文    | 81    |
|  3 | 李四  | 语文    | 76    |
|  5 | 王五  | 语文    | 81    |
+----+------+---------+-------+


+----+------+---------+-------+--------------------+
| id | name | kecheng | score | GROUP_CONCAT(name) |
+----+------+---------+-------+--------------------+
|  1 | 张三  | 语文    | 81    | 张三,张三           |
|  3 | 李四  | 语文    | 76    | 李四,李四           |
|  5 | 王五  | 语文    | 81    | 王五,王五,王五      |
+----+------+---------+-------+--------------------+


```

###  int (3)   int (5) 区别,是否需要零填充

```
#没有使用零填充 init(3)  
CREATE TABLE `test` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

mysql> select * from test;
+----+------+
| id | name |
+----+------+
|  1 | 许褚  |
|  2 | 郭嘉  |
|  3 | 贾诩  |
+----+------+

#使用零填充 init(3)  zerofill 
CREATE TABLE `test` (
  `id` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

mysql> select * from test;
+-----+------+
| id  | name |
+-----+------+
| 001 | 许褚  |
| 002 | 郭嘉  |
| 003 | 贾诩  |
+-----+------+
3 rows in set (0.00 sec)

#使用零填充 init(5)  zerofill 
CREATE TABLE `test` (
  `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

mysql> select * from test;
+-------+------+
| id    | name |
+-------+------+
| 00001 | 许褚  |
| 00002 | 郭嘉  |
| 00003 | 贾诩  |
+-------+------+
3 rows in set (0.00 sec)
```

![int zerofill](/img/ubuntu/mysql/other/int.png "init zerofill")

###  mysql 存储引擎

```
#InnoDB表引擎
通过一些机制和工具支持真真的热备份
支持奔溃后的安全恢复
支持行级锁
支持外键

#MyISAM表引擎
5.1版本之前,MyISAM是默认的存储引擎
拥有全文索引、压缩、 空间函数
不支持事务和行级锁,不支持奔溃后的安全恢复
表存储在两个文件,MYD和MYI
```

### mysql 锁

```
当多个查询同一时刻进行数据修改时,就会产生并发控制的问题, 共享锁(读锁) 、排他锁(写锁)

#共享锁(读锁)
共享的,不堵塞,多个用户可以同时读取一个资源,互不干扰
#排他锁(写锁)
排他的,一个写锁会阻塞一塔的写锁和读锁,这样可以值允许一个人写进行写入,防止其他用户读取正在写入的资源

#demo共享锁(读锁)
select * from test; 
lock table test read; #共享锁
unlock TABLES;  #解锁
update test set name="贾诩_update" where id=03; 

#排他锁  执行完lock加锁后,update 结束后及时执行解锁操作
lock tables test write;
update test set name="贾诩_update" where id=03;
unlock TABLES;
在排他锁执行期间.在当前窗口其他SQL是不能执行的,

#通过进程id, kill 掉锁
show processlist;  #查看锁状态
kill id  #杀掉等待sql
show OPEN TABLES where In_use > 0; #查看是否有在锁表
```

```
粒度锁

#表锁
系统性能开销最小,会锁定整张表,MyISAM 使用表锁
#行锁
最大程度地支持并发处理,但是也带来了最大的的锁开销,InnoDb 实现行级锁
```

```
#Mysql 存储过程
使用场景,通过处理把封装在容易使用的单元中,简化复杂的操作,保证数据的一致性
```

### mysql 索引

```mysql
#索引类型: 普通索引(index  另一个名字normal)、唯一索引(unique)、全文索引(fulltext)、空间索引(SPATIAL)
ALTER TABLE `test`.`test` 
ADD INDEX `id_score_score2`(`id`, `score`, `score2`);

ALTER TABLE `test`.`test` 
ADD UNIQUE INDEX `id_score_score2`(`id`, `score`, `score2`);

ALTER TABLE `test`.`test` 
ADD FULLTEXT INDEX `id_score_score2`(`id`, `score`, `score2`);

ALTER TABLE `test`.`test` 
ADD SPATIAL INDEX `id_score_score2`(`id`, `score`, `score2`);


```

### mysql 连接查询

```mysql
#自己关联自己查询
select * from test a1 inner join  test a2 on a1.score=a2.score2
```

### 数据库优化

查找分析查询速度慢的原因 ↓

1. ↑优化查询过程中的数据访问 **↓↓**
2. ↑优化长难查询语句 **↓↓**
3. ↑优化特定类型的查询语句 **↓↓**

#### **↑↑**查找分析查询速度慢的原因

1. ```
   分析SQL查询慢的方法
      记录慢查询日志
      分析查询日志,不要直接打开慢日志进行分析,
      这样比较浪费时间和经理,可以使用pt-query-digest工具进行分析
   ```

2. ```
   使用show profile
   	set profiling=1;开启,服务器上执行的所有语句会检测消耗的时间,存到临时表中
   	show profiles
   	show profile for query 临时表ID
   ```

3. ```
   使用show status
   	show status 会返回一些计数器,show global status查看服务器级别的所有计数
   	有时候根据这些计数,可以猜测出那些操作代价较高或者消耗时间多
   ```

4. ```
   使用show processlist
   	观察是否有大量线程处于不正常的状态护着特征
   ```

5. ```
   使用explain
   	分析单条SQL语句
   ```

6. ```
   - 访问数据太多导致查询性能下降
   - 确定应用程序是否存在检索大量超过需要的数据,可能是太多行或列
   - 确认MySQL服务器是否存在分析大量不必要的数据行
   ```

#### **↑↑** 优化查询过程中的数据访问

1. ```
   避免使用如下SQL语句
   	-  查询不需要的记录,使用limit解决
   	多表关联返回全部列,指定A.id,A.name,B.age
   		-  总是取出全部列,select * 会让优化器无法完成索引覆盖扫描的优化
        	-  重复查询相同的数据,可以缓存数据,下次直接读取缓存
   ```

2. ```
       是否在扫描额外的记录
        - 使用explain来进行分析,如果发现查询需要扫描大量的数据大只返回少数的行,
           可以通过以下技巧去优化:
        --  使用索引覆盖扫描,吧所有用的列都放在索引中,
             这样存储引擎不需要返回表获取对应行就可返回结果
        --  改变数据库和表结构,修改数据表范式
        --  重写SQL语句,让优化器可以以更优的方式进行执行查询
   ```


#### **↑↑** 优化长难语句查询语句

1. ```
   切分查询 
      将一个大的查询分为多个小的相同的查询:
      一次行删除1000万的数据要比一次删除一次1万更加损耗服务器开销,
      [可先先删除一万暂停一会儿在删除一万]
   
   其他:一个复杂查询还是多个简单查询???
        MySQL内部每秒能扫描内存中上百万行数据,相比之下,相应数据给客户端就压慢很多
   	使用尽可能少的查询是好的,但是有时将一个大的查询分解为多个小的查血是很有必要的
   ```

2. ```
   分辨关联查询
   	可以将一条关联语句分解成多条SQL来执行,好处:
   		让缓存的效率更高
   		执行单个查询可以减少锁的竞争
   		在应用层做关联可以更加容易对数据进行拆分,
   		查询效率会有大幅提升
   		较少冗余记录查询
   ```
#### **↑↑** 优化特定类型的查询

1. ```
   优化 count() 查询
       count(*)中的*会忽略所有的列,直接统计所有列数,因此不要使用count(别名)
       MyISAM中,没有任何where条件非常快
       可以使用explain查询近似值,用近似值代替count(*),
       增加汇总表
       使用缓存
   ```

2. ```
   优化关联查询
       确定on或者using子句的列上有索引
       确保group by 和 order by 中只有一个表中的列,这样MySQL才有可能使用索引
   ```

3. ```
   优化子查询
       尽可能使用关联查询代替  
   ```

4. ```
   优化group by 和 distinct 
   	这两种查询可使用索引来优化,是最有效的优化方法
   	关联查询中,使用表示列进行分组的效率会更高
   	如果不需要order by ,进行group by 时使用order by NUll,MySQL不会进行文件排序
       
   ```

5. ```
   优化limit分页
       limit 便宜量大的时候,查询效率较低,可以记录上次查询的最大id
       下次查询的时候直接根据该id来查询 
   ```
6. ```
   优化union查询
   	union all 的效率高于union   
   ```

7. 综上, 数据库优化: 先找原因定位低效SQL语句,然后根据SQL语句坑你低效的原因做排查,先从索引着手,如果索引没有问题,考虑以上几个方面,数据库访问的问题,长难度语句的问题还是一些特定类型优化的问题









