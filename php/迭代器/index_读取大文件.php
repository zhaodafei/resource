<?php

//@link https://www.php.net/manual/zh/language.generators.syntax.php
//@link https://www.php.net/manual/zh/language.generators.syntax.php

header('content-type:text/html;charset=utf-8');

// $fd = fopen("./fei.txt",'a');
// for ($i = 0; $i < 10; $i++) {
//     // file_put_contents('fei.txt', "this is $i "."line".PHP_EOL, FILE_APPEND);
//     fwrite($fd, "this is $i " . "line" . PHP_EOL);
// }
// fclose($fd);

function readText()
{
    $handle = fopen("./fei.txt", 'rb');
    while (feof($handle) === false) {
        yield fgets($handle);
    }
    fclose($handle);
}

$readTextCon1 = readText();
foreach ($readTextCon1 as $key => $value) {
    echo $value . '<br />';
}
