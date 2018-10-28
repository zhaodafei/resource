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

