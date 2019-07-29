<?php

// CREATE TABLE `student_01` (
// `id` int(11) NOT NULL AUTO_INCREMENT,
//   `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '名字',
//   `kecheng` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
//   `score` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
//   `other_id` int(11) DEFAULT NULL,
//   PRIMARY KEY (`id`) USING BTREE,
//   KEY `aaaa` (`other_id`) USING BTREE
// ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

//输入变量的数据处理
//输入变量的过程如下:
// 01) 预备(解析)语句  02) 绑定变量 03) 赋值到绑定变量 04) 执行预备语句
$conn = mysqli_connect('127.0.0.1', 'afei2', '123456', 'test');
$conn->query("set names utf8mb4");
$stmt = $conn->prepare("INSERT INTO student_01(name, kecheng, score,other_id) VALUES (?, ?, ?, ?)");
$stmt->bind_param('ssdi',$name, $kecheng, $score,$other_id);//第一个参数是指定类型

$name = '大飞';
$kecheng = '数学';
$score = 75;
$other_id = 1;
$stmt->execute();

$name = '大飞02';
$kecheng = '语文';
$score = 60;
$other_id = 1;
$stmt->execute();

$stmt->close();


//绑定变量获取的例子
//输出变量的过程如下:
// 01) 预备(解析)语句   02) 执行预备语句   03) 绑定输出变量  04) 把数据提取到输出变量中
$conn = mysqli_connect('127.0.0.1', 'afei2', '123456', 'test');
$conn->query("set names utf8mb4");
$stmt = $conn->prepare("SELECT id,name,kecheng,score FROM student_01");
$stmt->bind_result($id, $name,$kecheng,$score);//这里定义的变量
$stmt->execute();
print "<table  border='1' >" . PHP_EOL;
print "<tr><th>ID</th><th>姓名</th><th>课程</th><th>分数</th></tr>" . PHP_EOL;
while ($stmt->fetch()) {
    print "<tr><td>$id</td><td>$name</td><td>$kecheng</td><td>$score</td></tr>" . PHP_EOL;
}
print "</table>" . PHP_EOL;
$stmt->close();