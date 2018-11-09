<?php

// 桥接模式 bridge

// 论坛给用户发消息,可以是站内短息,email,手机

interface msg
{
    public function send($to, $content);
}

class zn implements msg
{
    public function send($to, $content)
    {
        // TODO: Implement send() method.
        echo ' 站内信给 ', $to, ' 内容 ', $content;
    }
}

class email implements msg
{
    public function send($to, $content)
    {
        // TODO: Implement send() method.
        echo 'email 给', $to, ' 内容 ', $content;
    }
}

class sms implements msg
{
    public function send($to, $content)
    {
        // TODO: Implement send() method.
        echo ' 短信给', $to, '内容', $content;
    }
}

// 内容也分普通,加急,特急
/**
 *  class zncommon extends msg
 *  class znwarn extends msg
 *  class zndanger extends msg
 *
 *  class emailcommon extends email
 *  class emailwarn extends email
 *  class emaildanger extends email
 */
/**
 *  思考:
 *      信的发送方式是一个变化因素
 *      信的紧急程度是一个变化因素
 *      为了不修改父类,只好考虑 2 个因素的组合,不停的产生新类................
 */