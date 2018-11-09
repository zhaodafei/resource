<?php

// php 责任链模式来处理举报问题

class board
{
    protected $power = 1;
    protected $top = 'admin';

    public function process($lev)
    {
        if ($lev <= $this->power) {
            echo ' 版主删帖 ';
        } else {
            $top = new $this->top;
            $top->process($lev);
        }

    }
}

class admin
{
    protected $power = 2;
    protected $top = 'police';

    public function process($lev)
    {
        if ($lev <= $this->power) {
            echo " 管理员封号 ";
        } else {
            $top = new $this->top;
            $top->process($lev);
        }
    }
}

class police
{
    protected $power;
    protected $top = null;

    public function process($lev)
    {
        echo ' 抓起来';
    }
}


// 责任链模式来处理举报问题
$lev = $_POST['jubao'] + 0;
$judge = new board();
$judge->process($lev);

