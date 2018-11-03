---
title: -PHP 易出错
---

### isset

```php
$bar = '';
var_dump(isset($bar));   // 输出 true

$foo;
var_dump(isset($foo));  // 输出 false
```

### 值传递 引用传递

```php
$a = "hello";
$b = &$a;
unset($b);
$b = "world";
echo $a;  // 输出 hello
```

### 运算符

```php
$a= 10;
$b = 0;
//echo $a / $b;  //除数不能为零

$x = -10;  // 换成 10 , -10 各自试试
$y = -3;   // 换成 3 ,  -3  各自试试
echo $x % $y;  // 输出 -1
```

### PHP && JavaScript 易错  01

```php
//----------------- PHP ---------------------
//function t($a){
//    $a += 1;
//}
//
//$b = 3;
//t($b);
//
//echo $b; //输出 3

//----------------- PHP ---------------------
//function t2(&$a)
//    $a += 1;
//}
//
//$b = 3;
//t2($b);
//
//echo $b; //输出 4

//-------------- JavaScript --------------
<script>
    var c = 5;
    function t1() {
        var d = 6;
        function t2() {
            var e = 7;
            alert(c + d + e);
        }

        t2();
    }
    t1();  //输出 18
</script>
```

### PHP && JavaScript 易错  02

```php
//----------------- PHP ---------------------
<?php
function a()
{
    echo "aaaaaa";
}

function a()
{
    echo "bbbbbbbbb";
}

a();  //第二个 a() 方法报错

//----------------- JavaScript ------------
function a() {
    console.log('11');
}
function a() {
    console.log('22');
}

a(); // 输出 22

```

### PHP 数组01

```php
$arr = [2 => 'a',1.6=>'222','2.5'=>'ddd','2'=>'eeee'];
print_r($arr);
//输出
Array
(
    [2] => eeee
    [1] => 222
    [2.5] => ddd
)

```

### PHP数组 02

```php
$arr = ['a' => '黄盖', 'b' => '周瑜', 'c' => null];
if (isset($arr['c'])) {  //isset — 检测变量是否已设置并且非 NULL
    echo "c 号单元存在";
} else {
    echo "c 号单元不存在";
}

if (array_key_exists('c',$arr)) {
    echo "c 号单元存在";
} else {
    echo "c 号单元不存在";
}
```

### 浮点数不准确

```php
// 浮点数不准确
//  银行存钱一般都存整数
if ((0.3 - 0.2) == 0.1) {  
    echo  "相等";
}else{  // 走这里
    echo "不";
}
```

