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

### 大小写替换

```php
// 大小写替换
// 请写一个函数,实现以下功能: 字符串"open_door" 转换成 "OpenDoor"
// "make_by_id" 转换成 "MakeById"

function strHandle($str)
{
    $res = '';
    $arr = explode('_', $str);
    foreach ($arr as $val) {
        $res .= ucfirst($val);
    }
    return $res;
}

echo strHandle('open_door'); // OpenDoor
echo strHandle('make_by_id'); // MakeById
```

### 数组合并

``` php
// 写一个函数实现PHP数组合并功能
// array_merge($arr1,$arr2,$a.....$arrn)

function array_mer()
{
    $res = [];
    $arrays = func_get_args();
    foreach ($arrays as $arr) {
        if (is_array($arrays)) {
            foreach ($arr as $val) {
                $res[] = $val;
            }
        }
    }
    return $res;
}

print_r(array_mer([1], [1, 2], [3, 4]));
```

