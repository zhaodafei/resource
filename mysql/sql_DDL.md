---
title: -sql -DDL
---

### 列操作

```mysql
desc 表名;  ...................................... #查看表结构
alter table 表名 add 列名称 属性;    .............. # 添加列
alter table 表名 add 列名称 属性 after 列名;  ...   # 指定在某列后面添加
alter table 表名 drop 列名;      ..............    #删除列名
alter table 表名 change 旧列名 新列名 新属性  .....  #修改列名
alter table a modify change_username varchar(20) ; # 修改列属性

alter table a add new_username char(10);         # 添加列
alter table a add new_username2 char(10) after id; # 添加列,指定在某列后面添加
alter table a drop new_username2;    #删除列名
alter table a change new_username change_username char(5);  # 修改列名
alter table a modify change_username varchar(20);   #修改列属性
```

### 表操作

```mysql
show tables;  #查看所有表
desc 表名;    #查看表结构
show create table 表名;  # 查看创建表sql
show tables;  #查看表信息
show table status where name ='表名';  # 查看某一张表信息
rename table 旧表名 to 新表名 #修改表名字
delete from user_t; #清空表内容
truncate user_t;    #清空表内容 id 从最初开始
```

### 索引????

```mysql
#普通索引(index  另一个名字normal)、
#唯一索引(unique)、
#全文索引(fulltext)、
#空间索引(SPATIAL)

unique key email(email(10))  #使用索引长度
alter table 表名 add  index 索引名(字段名) #添加普通索引
alter table 表名 drop index 索引名    #删除索引
show index from 表名    #查看索引

create table a1(
    name char(5),
    email char(15),
    key name(name),
    unique key email(email)
);

#多列索引
create table a3(
    name char(5),
    email char(15),
    key name(name),
    unique key name_email(name,email)
);
explain select * from a3 WHERE name="张"; # 分析sql
alter table a1 add unique(name);  # 添加唯一索引
alter table a1 add index index_name(email) #添加普通索引
alter table a1 drop index index_name    #删除索引
show index from a1 \G    #查看索引
```

### !!!库操作  [此操作比较危险,请谨慎操作]

```
create database 数据库; #创建库
create database 数据库 default character set 字符集 collate 排序规则; #创建库指定字符集

create database yourdb; #创建库
create database yourdb3 default character set utf8mb4 collate utf8mb4_unicode_ci; #创建库指定字符集

!!! 数据库的的名字不要直接修改,容易丢数据!!!
```

