<?php
// 策略模式

interface Math
{
    public function calculate($op1, $op2);
}

class MathAddition implements Math
{
    public function calculate($op1, $op2)
    {
        // TODO: Implement calculate() method.
        return $op1 + $op2;
    }
}

class MathSubtraction implements Math
{
    public function calculate($op1, $op2)
    {
        // TODO: Implement calculate() method.
        return $op1 - $op2;
    }
}

class MathMultiplication implements Math
{
    public function calculate($op1, $op2)
    {
        // TODO: Implement calculate() method.
        return $op1 * $op2;
    }
}


class MathDivision implements Math
{
    public function calculate($op1, $op2)
    {
        // TODO: Implement calculate() method.
        return $op1 / $op2;
    }
}

/*
 *  传来 OP, 根据 OP ,制造出对象,不对对象并且调用
 */
// 封装1个虚拟计算机
class CMath{
    protected $calculate = null;
    public function __construct($type)
    {
        $calculate = 'Math' . $type;
        $this->calculate = new $calculate();
    }

    public function calculate($op1, $op2)
    {
        return $this->calculate->calculate($op1, $op2);
    }
}

$type = $_POST['op'];
$cmath = new CMath($type);
echo $cmath->calculate($_POST['op1'], $_POST['op2']);