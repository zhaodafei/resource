<?php

$mysqli = new mysqli("mysql", "root", "root", "example");

if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

$charset = $mysqli->character_set_name();
printf ("Current character set is %s\n", $charset);

$mysqli->close();