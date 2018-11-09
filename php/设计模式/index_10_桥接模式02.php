<?php

// 桥接模式 bridge

// 论坛给用户发消息,可以是站内短息,email,手机

abstract class info
{
    protected $send = null;

    public function __construct($send)
    {
        $this->send = $send;
    }

    abstract public function msg($content);

    public function send($to, $content)
    {
        $content = $this->msg($content);
        $this->send->send($to, $content);
    }
}

class zn
{
    public function send($to, $content)
    {
        echo ' 站内给 ', $to, ' 内容是: ', $content;
    }
}

class email
{
    public function send($to, $content)
    {
        echo ' email给 ', $to, ' 内容是: ', $content;
    }
}

class sms
{
    public function send($to, $content)
    {
        echo ' sms给 ', $to, ' 内容是: ', $content;
    }
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class commonInfo extends info
{

    public function msg($content)
    {
        // TODO: Implement msg() method.
        return ' 普通 ' . $content;
    }
}

class warnInfo extends info
{

    public function msg($content)
    {
        // TODO: Implement msg() method.
        return ' 紧急 ' . $content;
    }
}

class dangerInfo extends info
{
    public function msg($content)
    {
        // TODO: Implement msg() method.
        return ' 特急 ' . $content;
    }
}

// 用站内发普通消息
$commonInfo = new commonInfo(new zn());
$commonInfo->send('小飞飞', 'hello world');

echo '<br>';
// 用手机发特急信息
$dangerInfo = new commonInfo(new sms());
$dangerInfo->send('飞', '这是手机信息');




