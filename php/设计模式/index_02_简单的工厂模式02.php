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

// 简单工厂方法
class Factory
{
    public static function createDB($type)
    {
        if ($type == 'mysql') {
            return new dbmysql();
        } elseif ($type == 'sqlite') {
            return new dbsqlite();
        }else{
            throw new Exception("Error db type");
        }
    }
}

// 简单工厂方法
$factory_mysql = Factory::createDB('mysql');
$factory_mysql->conn();

$factory_sqlite = Factory::createDB('sqlite');
$factory_sqlite->conn();

// ????????那么问题来了
// 如果新增了 oracle 类型怎么办 ??????
// 服务端要修改, Factory 的内容 ( 在 java, c++ 中,改后还得再编译)
// 在面向对象设计法则中,重要的开闭原则, ----  对于修改是封闭的,对于扩展是开放的








