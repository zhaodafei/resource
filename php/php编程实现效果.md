---
title: --php编程实现效果
---

### 字符串翻转

```php
function reverse($var)
{
    $res = "";
    for ($i = 0, $j = strlen($var); $i < $j; $i++) {
        $res = $var[$i] . $res;
    }
    return $res;
}

$tmp = "fei";
$res = reverse($tmp);
echo $res;

//----------------
$aa = 'abc';
echo $aa[0];  //输出 a
```

