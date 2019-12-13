<?php
header('Access-Control-Allow-Headers: X-CSRF-Token, Origin, X-Requested-With, Content-Type, Accept, x-csrftoken');
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Methods: POST,GET,OPTIONS');
require_once '../objects/Login.php';
require_once '../objects/Streamer.php';

if (empty($_GET['secret']) || empty($_GET['user']) || empty($_GET['timestamp'])) {
    echo 'error in param';
    header('content-type:text/html;charset=uft-8');
    header($_SERVER['HTTP_REFERER']);
}

$secret = $_GET['secret'];
$user = $_GET['user'];
$timestamp = $_GET['timestamp'];

$private_key_file = '../rsaprivatekey.pem';
if (!file_exists($private_key_file)) {
    echo 'No rsa file!';
    header('content-type:text/html;charset=uft-8');
    header($_SERVER['HTTP_REFERER']);
}
$decrypted = "";
$private_key = file_get_contents($private_key_file);
$pi_key =  openssl_pkey_get_private($private_key);//这个函数可用来判断私钥是否是可用的，可用返回资源id Resource id
openssl_private_decrypt(base64_decode($secret),$decrypted,$pi_key);//私钥解密
$start_res = explode('&', $decrypted);
$params = array();

foreach ($start_res  as $res) {
    $item = explode('=', $res);
    $params[$item[0]] = $item[1];
}

$user = $params['user'];
$pass = $params['pass'];
$siteURL = $params['siteURL'];

if ($user != $_GET['user'] || $timestamp != $params['timestamp']) {
    echo 'error data!';
    header('content-type:text/html;charset=uft-8');
    header($_SERVER['HTTP_REFERER']);
}

Login::run($user, $pass, $siteURL, false);
$targeturl = $global['webSiteRootURL']
?>
<html>
<head>
    <meta http-equiv="refresh" content="1;url=<?php echo $targeturl; ?>">
</head>
<body>
jump to your target!
</body>
</html>
