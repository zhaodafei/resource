<?php

// @link https://www.php.net/manual/zh/class.iterator.php
// @link https://www.php.net/manual/zh/class.iterator.php

class myIterator implements Iterator
{
    private $position = 0;
    private $arr = ["早晨", "上午", "下午", "晚上"];

    public function current()
    {
        // print_r(__METHOD__);
        return $this->arr[$this->position];
    }

    public function next()
    {
        // print_r(__METHOD__);
        ++$this->position;  //下标移动一个
    }

    public function key()
    {
        // print_r(__METHOD__);
        return $this->position;
    }

    public function valid()
    {
        // print_r(__METHOD__);
        return isset($this->arr[$this->position]);
    }

    public function rewind()
    {
        $this->position = 0;
    }
}

$it = new myIterator();
foreach ($it as $k => $v) {
    // var_dump($k, $v);
    // echo PHP_EOL;
    echo $k . "===>" . $v . "<br>";
}
