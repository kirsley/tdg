<?php
include_once 'includes/headers.php';
$errors="";
    if (isset($_POST['lreset'])){
        unset($_SESSION['language']);
    }elseif (isset($_POST['language'])){
        $_SESSION['language'] = $_POST['language'];
    }
    $mainDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
	$limit=6;
    	$start=0;
?>


<html>
<head>
<meta charset="utf-8">
<?php 
    include_once 'includes/mainlibsheader.php';
$lang='';
if(isset($_SESSION['language'])){
    $lang=$_SESSION['language'];
    if ($lang == 'cat'){
        echo "<title>Toc de Gralla - Bar / Restaurant</title>";
    }elseif ($lang == 'eng'){
        echo "<title>Toc de Gralla - Restaurant / Bar</title>";
    }else {
        echo "<title>Toc de Gralla - Bar / Restaurante</title>";
    }
} else {
    echo "<title>Toc de Gralla - Bar / Restaurante</title>";
}
?>
<link rel="stylesheet" href="css/main.css">
</script>
</head>
<body>
<?php 
    include_once 'includes/mainHeader.php' ;
    $category = $_GET['cat'];
    $prodUrl=explode(".",$_GET['prodname'])[0];
    $product=getProductByUrl($mainDbh,$prodUrl,$lang)[0];

    echo "<div id='producto'>";
    echo " <div class='imagen'>";
    echo "<img src='../" . $product->img_path . "' />";
    echo "</div>";
    include_once "botonesPlt.php";
	echo "</div>";
?>
 
</body>
<script type="text/javascript">
        <?php
                //Zona de errores
                if ($errors != ""){
                        echo "alert('$errors');";
                }
                desconectarpdo($mainDbh);
        ?>
</script>

</html>
