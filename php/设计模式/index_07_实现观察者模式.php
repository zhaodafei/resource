<?php
// ------------PHP 实现观察者模式
// php5中提供观察者 observer 与被观察者 subject 的接口
// @link http://php.net/manual/zh/class.splsubject.php
// @link http://php.net/manual/zh/class.splobjectstorage.php

class user implements SplSubject {

    //  attach()  detach()  notify()  PHP自带
    public function attach(SplObserver $observer)
    {
        // TODO: Implement attach() method.
        $this->observers->attach($observer);
    }


    public function detach(SplObserver $observer)
    {
        // TODO: Implement detach() method.
        $this->observers->detach($observer);
    }

    public function notify()
    {
        // TODO: Implement notify() method.
        $this->observers->rewind();
        while ($this->observers->valid()) {
            $observer = $this->observers->current();
            $observer->update($this); // 参数
            $this->observers->next();
        }

    }

    //--------------------------------------------
    public $lognum;
    public $hobby;

    protected $observers = null;

    public function __construct($hobby)
    {
        $this->lognum = rand(1, 10);
        $this->hobby = $hobby;
        $this->observers = new SplObjectStorage();
    }

    public function login()
    {
        // 操作 session...
        $this->notify();
    }

}


class security implements SplObserver{

    public function update(SplSubject $subject)
    {
        // TODO: Implement update() method.
        if ($subject->lognum < 3) {
            echo '这是第 ' . $subject->lognum . ' 次安全登录 ';
        }else{
            echo '这是第' . $subject->lognum . ' 次安全登录,异常 ';
        }
    }
}

class ad implements SplObserver{

    public function update(SplSubject $subject)
    {
        // TODO: Implement update() method.
        if ($subject->hobby == 'sports'){
            echo ' 台球英锦赛门票预订 ';
        }else{
            echo ' 好好学习,天天向上 ';
        }
    }
}

// 实施观察
$user = new user('sports');
$user->attach(new security());
$user->attach(new ad());

$user->login();