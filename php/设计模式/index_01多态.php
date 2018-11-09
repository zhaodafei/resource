<?php

//多态   虎--> 西伯利亚虎(XTiger), 孟加拉虎(MTiger)
//  西伯利亚虎不会爬树, 孟加拉虎会爬树
abstract class Tiger
{
    public abstract function climb();
}

class XTiger extends Tiger
{
    public function climb()
    {
        // TODO: Implement climb() method.
        echo " 摔下来 ";
    }
}

class MTiger extends Tiger
{
    public function climb()
    {
        // TODO: Implement climb() method.
        echo " 爬到树顶 ";
    }
}

class Client
{
    // java 中 call(Tiger $animal) ,声明忽的父类 Tiger ,只能传虎,虎的子类,
    //  这时候,猫就不能上树,会报错
    public function call(Tiger $animal)
    {
        $animal->climb();
    }
}


$XtigerClient = new Client();
$XtigerClient->call(new XTiger());

$MtigerClient = new Client();
$MtigerClient->call(new MTiger());

// 猫飞上天 :)

class Cat
{
    public function climb()
    {
        echo " 飞到天上去 ";
    }
}

$CatClient = new Client();
$CatClient->call(new Cat());