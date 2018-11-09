<?php
// 简单的工厂模式----01
// 比如,螺丝和螺口; 灯泡和灯口;  插座和插头;
// 他们为什么可以匹配,因为有个共同的尺寸大小规定,这就是共同的接口

// 面向接口开发, 多个人开发,对方看不到
// 服务端开始打包

// 共同接口
interface db
{
    function conn();
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

// --- 客户端,看不到 dbmyql,dbsqlite 的内部接口
//  只知道,dbmyql,dbsqlite 实现了 db 接口
$db_mysql = new dbmysql();
$db_mysql->conn();

$db_sqlite = new dbsqlite();
$db_sqlite->conn();


// ????? 那么问题来了,客户端怎么知道我的 dbmysql , dbsqlite 类, 以后我还可能增加更多的类,怎么办???????


