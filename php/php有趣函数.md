---
title: php有趣函数
---

func_get_args  函数

```php
// 返回一个包含函数参数列表的数组
function test()
{
    print_r(func_get_args());
}

test(1,2,3); // 输出 Array ( [0] => 1 [1] => 2 [2] => 3 )
```

