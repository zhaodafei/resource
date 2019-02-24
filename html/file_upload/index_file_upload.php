<?php
// exit('dddddddddd');//zhey
if (!file_exists('./upload/up1.wmv')) {
    move_uploaded_file($_FILES['part']['tmp_name'], './upload/up1.wmv');
} else {
    file_put_contents('./upload/up1.wmv', file_get_contents($_FILES['part']['tmp_name']), FILE_APPEND);
}
echo 'ok-php';