<?php

// php 面向过程完成举报功能

$lev = $_POST['jubao']+0;

class board{
    public function process()
    {
        echo ' 版主删帖 ';
    }
}

class admin{
    public function process()
    {
        echo " 管理员封号 ";
    }
}

class police{
    public function process()
    {
        echo ' 抓起来';
    }
}

if ($lev == 1) {
    $judge = new board();
    $judge->process();
}else if ($lev == 2) {
    $judge = new admin();
    $judge->process();
}else{
    $judge = new police();
    $judge->process();
}
