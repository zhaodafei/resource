<?php

// 运行 php index.php
//创建websocket服务器对象，监听0.0.0.0:9502端口
// $ws = new  swoole_websocket_server('0.0.0.0', 9505);
$ws = new  swoole_websocket_server('192.168.56.11', 9506,SWOOLE_BASE);

$ws->set([ //配置选项 https://wiki.swoole.com/wiki/page/276.html
    'worker_num' =>1,
    'task_worker_num' => 1,//配置后必须注册 onTask onFinish 2 个回调函数
    // 'daemonize' => 1, //后台运行
    // 'log_file' => __DIR__.'/log/swoole.log' //后台运行后使用日志
]);

//监听WebSocket连接打开事件
$ws->on('open', function ($ws, $request) {
    // var_dump($request->fd, $request->get, $request->server);
    $ws->push($request->fd, "hello welcome\n");
});

//监听WebSocket消息事件, 接受前端数据
$ws->on('message', function ($ws, $frame) {
    // echo "Message: {$frame->data}\n";
    echo PHP_EOL . "--->message<---" . PHP_EOL; //写入到swoole.log
    $ws->task($frame);// 接受到一个消息,投递一次任务,然后Task回调执行-------
    $ws->push($frame->fd, "server: {$frame->data}");
});
$ws->on('Task', function () {//worker_num 配置后必须注册
    echo PHP_EOL . "--->Task<---" . date('Y-m-d H:i:s') . PHP_EOL;
});
$ws->on('Finish', function(){//worker_num 配置后必须注册
    echo PHP_EOL . "--->Finish<---" . date('Y-m-d H:i:s') . PHP_EOL;
});


//监听WebSocket连接关闭事件
$ws->on('close', function ($ws, $fd) {
    echo "client-{$fd} is closed";
});

//多久执行一次
$ws->on('WorkerStart', function ($ws, $worker_id) {
    if ($worker_id == 0) {
        $ws->tick(100000, function () use ($ws) {
            echo PHP_EOL . "--->tick<---" . date('Y-m-d H:i:s') . PHP_EOL;
        });
    }
});


$ws->start();


// swoole_timer_tick(2000, function ($timer_id) {
//     echo "tick-2000ms\n";
// });


















