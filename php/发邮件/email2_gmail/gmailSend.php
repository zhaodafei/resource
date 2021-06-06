<?php
/**
 * This example shows settings to use when sending via Google's Gmail servers.
 * The IMAP section shows how to save this message to the 'Sent Mail' folder using IMAP commands.
 * 这个使用 PHPMailer5.2.26 版本
 * 使用 Gmail 邮箱服务
 *
 * https://github.com/PHPMailer/PHPMailer/releases/tag/v5.2.26
 * https://github.com/PHPMailer/PHPMailer/releases/tag/v5.2.26
 *
 */

//SMTP needs accurate times, and the PHP time zone MUST be set
//This should be done in your php.ini, but this is how to do it if you don't have access to that
date_default_timezone_set('Etc/UTC');

// 引入PHPMailer的核心文件
require_once("PHPMailer/PHPMailerAutoload.php");


//Create a new PHPMailer instance
$mail = new PHPMailer;

//Tell PHPMailer to use SMTP
$mail->isSMTP();

//Enable SMTP debugging
// 0 = off (for production use)
// 1 = client messages
// 2 = client and server messages
$mail->SMTPDebug = 2;

//Ask for HTML-friendly debug output
$mail->Debugoutput = 'html';

//Set the hostname of the mail server
$mail->Host = 'smtp.gmail.com';
// use
// $mail->Host = gethostbyname('smtp.gmail.com');
// if your network does not support SMTP over IPv6

//Set the SMTP port number - 587 for authenticated TLS, a.k.a. RFC4409 SMTP submission
$mail->Port = 587;

//Set the encryption system to use - ssl (deprecated) or tls
$mail->SMTPSecure = 'tls';

//Whether to use SMTP authentication
$mail->SMTPAuth = true;

//Username to use for SMTP authentication - use full email address for gmail
$mail->Username = "username@gmail.com"; // todo:  smtp登录的账号,Gmail邮箱即可

//Password to use for SMTP authentication
$mail->Password = "*************"; // todo:  smtp登录的密码 使用生成的授权码

//Set who the message is to be sent from (设置发件人邮箱地址 同登录账号)
$mail->setFrom('from@example.com', 'form daFei'); // todo:

//Set an alternative reply-to address ( 设置另一个应答地址 )
// $mail->addReplyTo('replyto@example.com', 'First Last');

//Set who the message is to be sent to  (设置收件人邮箱地址)
$mail->addAddress('whoto@example.com', 'to Hello World'); // todo:

//Set the subject line (添加该邮件的主题)
$mail->Subject = 'PHPMailer GMail SMTP test 邮件主题'; // todo:

//Read an HTML message body from an external file, convert referenced images to embedded,
//convert HTML into a basic plain-text alternative body
// $mail->msgHTML(file_get_contents('contents.html'), dirname(__FILE__));

//Replace the plain text body with one created manually
// $mail->AltBody = 'This is a plain-text message body';
$mail->Body = '<h1>Hello World</h1>';

//Attach an image file
// $mail->addAttachment('images/phpmailer_mini.png');

//send the message, check for errors
if (!$mail->send()) {
    echo "Mailer Error: " . $mail->ErrorInfo;
} else {
    echo "Message sent!";
    //Section 2: IMAP
    //Uncomment these to save your message in the 'Sent Mail' folder.
    #if (save_mail($mail)) {
    #    echo "Message saved!";
    #}
}

//Section 2: IMAP
//IMAP commands requires the PHP IMAP Extension, found at: https://php.net/manual/en/imap.setup.php
//Function to call which uses the PHP imap_*() functions to save messages: https://php.net/manual/en/book.imap.php
//You can use imap_getmailboxes($imapStream, '/imap/ssl') to get a list of available folders or labels, this can
//be useful if you are trying to get this working on a non-Gmail IMAP server.
function save_mail($mail) {
    //You can change 'Sent Mail' to any other folder or tag
    $path = "{imap.gmail.com:993/imap/ssl}[Gmail]/Sent Mail";

    //Tell your server to open an IMAP connection using the same username and password as you used for SMTP
    $imapStream = imap_open($path, $mail->Username, $mail->Password);

    $result = imap_append($imapStream, $path, $mail->getSentMIMEMessage());
    imap_close($imapStream);

    return $result;
}
