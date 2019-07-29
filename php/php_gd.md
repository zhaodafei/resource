---
title: php -GD 库制作图片
---
### php GD 库制作图片

```php
// GD 和图像处理函数
// https://www.php.net/manual/zh/ref.image.php
// https://www.php.net/manual/zh/ref.image.php
$size = 300;
$image=imagecreatetruecolor($size+200, $size+400);

// 用黑色边框得到白色背景的东西
$back = imagecolorallocate($image, 255, 255, 255);
$border = imagecolorallocate($image, 0, 0, 0);
imagefilledrectangle($image, 0, 0, $size + 150, $size + 100, $back);
imagerectangle($image, 0, 0, $size +150, $size + 100, $border);

$yellow_x = 200;
$yellow_y = 175;
$radius = 250;

// 使用 alpha 值分配颜色
$yellow = imagecolorallocatealpha($image, 255, 255, 0, 75);
$text_color = imagecolorallocate($image, 233, 14, 91);

// 画一个圆
imagefilledellipse($image, $yellow_x, $yellow_y, $radius, $radius, $yellow);
// 画一个矩形
// imagefilledrectangle($image,$yellow_x-100, $yellow_y-100, $radius+50, $radius+40, $yellow);
// 水平地画一行字符串
imagestring($image, 5, 150, 150, "hello world", $text_color);
// 垂直地画一行字符串
// imagestringup ($image, 5, 150, 150, "hello world", $text_color);

// 告诉浏览器输出 png 图片
header('Content-type: image/png');

// 输出结果
imagepng($image);
imagedestroy($image);
```

![gd](/img/php/gd.png "gd")



 [GD 和图像处理 函数](https://www.php.net/manual/zh/ref.image.php "GD 和图像处理 函数")





























