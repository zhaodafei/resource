---
title: sql DML (insert update delete select)基本使用
---

### 事务

```mysql
start transaction;
update 表名 set money=money+500 where id = 2;
update 表名 set money=money-500 where id = 1;
commit;

select * from 表名 where id =1;
select * from 表名 where id =2;

+++++++
start transaction;
update 表名 set money=money+500 where id = 2;
rollback;
```

### where  having  group查询

```mysql
要求:查询出2门及2门以上不及格者的平均成绩 demo sql如下:
--------------------------------------------------------------------------
CREATE TABLE `student2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` double(255,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `student2` VALUES ('1', '张三', '数学', '90');
INSERT INTO `student2` VALUES ('2', '张三', '语文', '50');
INSERT INTO `student2` VALUES ('3', '张三', '地理', '40');
INSERT INTO `student2` VALUES ('4', '李四', '语文', '55');
INSERT INTO `student2` VALUES ('5', '李四', '政治', '45');
INSERT INTO `student2` VALUES ('6', '王五', '政治', '30');
INSERT INTO `student2` VALUES ('7', '马六', '地理', '80');
INSERT INTO `student2` VALUES ('8', '马六', '英语', '90');

+----+------+---------+-------+--------+
| id | name | subject | score | score2 |
+----+------+---------+-------+--------+
|  1 | 张三     | 数学       |    90 |     10 |
|  2 | 张三     | 语文        |    50 |     10 |
|  3 | 张三     | 地理        |    40 |     10 |
|  4 | 李四     | 语文        |    55 |     10 |
|  5 | 李四     | 政治        |    45 |     10 |
|  6 | 王五     | 政治        |    30 |     10 |
|  7 | 马六     | 地理        |    80 |     10 |
|  8 | 马六     | 英语       |    90 |     10 |
+----+------+---------+-------+--------+
--------------------------------------------------------------------------

select name,subject,score,score<60 from student2
select name,sum(score<60) as gk ,avg(score) as pj  from student2  group by name 
select name,sum(score<60) as gk ,avg(score) as pj  from student2  group by name HAVING gk>=2
结果:
+--------+------+---------+
| name   | gk   | pj      |
+--------+------+---------+
| 张三   |    2 | 60.0000 |
| 李四   |    2 | 50.0000 |
+--------+------+---------+
+++++++++++++ having 是对表的结果进行查询筛选 ++++++++
select * from student2 where id>1
select * from student2 having id>1
select * from student2 where id>1 having id<5
```

### INNER JOIN 查询

```mysql
demos sql:
--------------------------------------------------------------------------
DROP TABLE IF EXISTS `m`;
CREATE TABLE `m` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hid` int(11) DEFAULT NULL COMMENT '主队ID',
  `gid` int(11) DEFAULT NULL COMMENT '客队ID',
  `mres` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '比赛结果',
  `matime` date DEFAULT NULL COMMENT '比赛开始时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `m` VALUES ('1', '1', '2', '2:0', '2006-05-21');
INSERT INTO `m` VALUES ('2', '2', '3', '1:2', '2006-06-21');
INSERT INTO `m` VALUES ('3', '3', '1', '2:5', '2006-06-25');
INSERT INTO `m` VALUES ('4', '2', '1', '3:2', '2006-07-21');


DROP TABLE IF EXISTS `t`;
CREATE TABLE `t` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '队伍名称',
  PRIMARY KEY (`tid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `t` VALUES ('1', '国安');
INSERT INTO `t` VALUES ('2', '申花');
INSERT INTO `t` VALUES ('3', '布尔联队');
--------------------------------多次使用INNER JOIN 查询----------------------
SELECT m.id,t1.tname,mres,t2.tname,matime FROM
 m
INNER JOIN t as t1 on m.hid=t1.tid 
INNER JOIN t as t2 ON m.gid=t2.tid
```

## union  和 union all

!!!!   使用union  waring:  
1.各语句的列数相同
2.列名称未必要一直,列名称会使用第一条sql 的列名称为准
3.完全相等行将会合并,合并是比较耗时的操作,使用"union all" 可以避免合并

```mysql
demos sql:
--------------------------------------------------------------------------
DROP TABLE IF EXISTS `a`;
CREATE TABLE `a` (
  `id` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `a` VALUES ('a', '5');
INSERT INTO `a` VALUES ('b', '10');
INSERT INTO `a` VALUES ('c', '15');
INSERT INTO `a` VALUES ('d', '10');

DROP TABLE IF EXISTS `b`;
CREATE TABLE `b` (
  `id` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `b` VALUES ('b', '5');
INSERT INTO `b` VALUES ('c', '15');
INSERT INTO `b` VALUES ('d', '20');
INSERT INTO `b` VALUES ('e', '99');
---------------------------------分组后求和--------------------------------------
select id,sum(num) from
(select id,num from a
union all
select id,num from b) as tmp
group by id;
```


