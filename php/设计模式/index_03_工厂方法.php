<?php

// 工厂方法
interface db
{
    function conn();
}

interface Factory   // 解决简单工厂中在扩展 其他数据库问题,比如新增 oracle 数据库 (开闭原则:对于修改是封闭,对于扩展是开放)
{
    function createDB();
}

//服务端开发(不知道将会被谁调用)
class dbmysql implements db
{
    public function conn()
    {
        // TODO: Implement conn() method.
        echo " 连接上Mysql ";
    }
}

class dbsqlite implements db
{
    public function conn()
    {
        // TODO: Implement conn() method.
        echo " 连接上了sqlite ";
    }
}

class mysqlFactory implements Factory{

    function createDB()
    {
        // TODO: Implement createDB() method.
        return new dbmysql();
    }
}

class sqliteFactory implements Factory
{

    function createDB()
    {
        // TODO: Implement createDB() method.
        return new dbsqlite();
    }
}


// =====  客户端开始 ====
$mysql_factory = new mysqlFactory();
$mysql_create = $mysql_factory->createDB();
$mysql_create->conn();

$sqlite_factory = new sqliteFactory();
$sqlite_create = $sqlite_factory->createDB();
$sqlite_create->conn();


//  新增 oracle 数据库
//  现在要在服务器端添加 oracle 类
class dboracle implements db{

    function conn()
    {
        // TODO: Implement conn() method.
        echo "连接上 oracle 数据库";
    }
}

class oracleFactory implements Factory
{

    function createDB()
    {
        // TODO: Implement createDB() method.
        return new dboracle();
    }
}

$oracle_factory = new oracleFactory();
$oracle_create = $oracle_factory->createDB();
$oracle_create->conn();




