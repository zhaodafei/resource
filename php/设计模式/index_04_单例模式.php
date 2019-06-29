<?php
// 单例模式 singleton

// -----------------第一步 普通类
/**
class singleton
{

}

$s1 = new singleton();
$s2 = new singleton();

// 注意,2个对象时一个的时候,才全等
if ($s1 === $s2) {
    echo " 是一个对象 ";
}else{   //输出: 不是一个对象
    echo " 不是一个对象";
}
 **/


// -----------------第二步 封锁 new 操作
/**
class singleton{
    protected function __construct()
    {
    }
}

$s1 = new singleton();  // 再次 new , protected 类报错,不能 new
 * */

// -----------------第三步 ,留一个接口, 来 new 对象
/**
class singleton
{
    public static function getIns()
    {
        return new self();
    }

    protected function __construct()
    {
    }
}

$s1 = singleton::getIns();
$s2 = singleton::getIns();

// 注意,2个对象时一个的时候,才全等
if ($s1 === $s2) {
    echo " 是一个对象 ";
}else{   //输出不是一个对象, 因为内部还是 new 了2次
    echo " 不是一个对象";
}
**/

// -----------------第四步  getIns 先判断实例
/**
class singleton
{
    protected static $ins = null;
    public static function getIns()
    {
        if (self::$ins == null) {
            self::$ins = new self();
        }
        return self::$ins;
        //return new self();
    }

    protected function __construct()
    {
    }
}

$s1 = singleton::getIns();
$s2 = singleton::getIns();

// 注意,2个对象时1个的时候,才全等
if ($s1 === $s2) { // 输出 是一个对象 ok ,
    echo "是一个对象";
} else {
    echo "不是一个对象";
}

//  -------  表面上是成功了,但是 子类继承后会不会出问题?????
class multi
{
    // 这里啥都不做,就继承父类  __construct
    public function __construct()
    {
    }
}

$s3 = new multi();
$s4 = new multi();
if ($s3 === $s4) {
    echo "是一个对象";
} else {  //  输出不是一个对象,  又不是一个对象了??????
    echo "不是一个对象";
}

 * */

// -----------------第五步 , 用 final ,仿制继承是,被修改权限
/**
class singleton
{
    protected static $ins = null;
    public static function getIns()
    {
        if (self::$ins == null) {
            self::$ins = new self();
        }
        return self::$ins;
        //return new self();
    }

    // 方法前加 final ,则方法不能被覆盖,类前加 final ,则类不能被继承
    final protected function __construct()
    {
    }
}


$s1 = singleton::getIns();
$s2 = clone $s1;   // 现在克隆对象, 又产生了一个对象

if ($s1 === $s2) {
    echo "是一个对象";
} else {  //  输出不是一个对象,  clone 后又不是一个对象了??????
    echo "不是一个对象";
}
**/

// -----------------第六步, 禁止克隆
/*class singleton
{
    protected static $ins = null;

    public static function getIns()
    {
        if (self::$ins == null) {
            self::$ins = new self();
        }
        return self::$ins;
        //return new self();
    }

    // 方法前加 final ,则方法不能被覆盖,类前加 final ,则类不能被继承
    final protected function __construct()
    {
    }

    // 封锁克隆 clone
    final protected function __clone()
    {
    }
}

$s1 = singleton::getIns();
$s2 = clone $s1;  //现在报错了,不能被 clone  终于成功了 ok */

//demo 2 单例模式---日志输出
class  Logger{
    static private $instance = null;

    static function getInstance()
    {
        if (self::$instance == null) {
            self::$instance = new Logger();
        }
        return self::$instance;
    }

    private function __construct()
    {
    }
    private function __clone()
    {
    }

    function Log($str)
    {
        //注意日志
        echo $str;
    }
}

Logger::getInstance()->Log("Checkpoint");