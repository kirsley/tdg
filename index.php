<?php
include_once 'includes/headers.php';
include_once 'includes/libsheader.php';
include_once 'includes/adminHeader.php'?>
<html>
<body>
<div style='position:relative;top:100px;'>
<?php 
if (isset( $_GET["p"])){
    $a = $_GET["p"];
    echo $a . "\n";
}
if (isset( $_GET["sp"])){
    $b = $_GET["sp"];
    echo $b . "\n";
}

    echo "Hola";
?>
</div>
</body>
</html>