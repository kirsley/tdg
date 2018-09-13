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
//print_r($_GET);
//Array ( [cat] => ensaladas [prodname] => amanida-cabra.php ) 
$category = $_GET['cat'];
$prodUrl=explode(".",$_GET['prodname'])[0];
//echo $prodUrl;
$product=getProductByUrl($mainDbh,$prodUrl,$lang)[0];

echo "<div id='producto'>";
/*product Object ( [id] => 18 [name] => Calamares andaluza [url] => calamares-andaluza [img_path] => uploads/calamares-andaluza1.jpg [cat_id] => 10 [cat_url] => tapas-calientes [translation] => Calamares a la andaluza )*/
     echo " <div class='imagen'>";
           echo "<img src='../" . $product->img_path . "' />";
                echo "</div>";

//$category=explode(".",$_GET['cat'])[0];
echo "<div class='botones'>";
 echo " <div class='boton' id='back' >";
         echo " <a href='../". $category ."' ><img src='../img/back.png' /></a>";
                 echo " </div>";

	echo "<div class='boton' id='lista'>";
	echo "<a href='../index'> <img src='../img/lista.png' /> </a>";
	echo "</div>";
            echo "          <div class=\"boton\" id=\"home\"  >";
            echo " <form action=\"../index\" method=\"post\" name=\"langReset\">";
            echo '<input type="hidden" name="lreset" value="reset">';
            echo "</form>";
            echo "          <img src='../img/home.png' onclick='resetLanguages()' /> ";
            echo "          </div>";

	echo "</div>";
	echo "</div>";
	echo "</div>";



//}
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
