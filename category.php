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
$category=explode(".",$_GET['cat'])[0];
$cat_id=getCategory($mainDbh,$category);

if ($cat_id > 0){
	$products=getProductsByCategory($mainDbh,$cat_id,$lang,$start,$limit);
//	print_r($products);
	$cnt=count($products);
	echo $cnt;
echo "<div id='cuerpo'>";
echo "<div id='producto'>";
/*	if($cnt<5){
		$divId="platos" . $cnt;
	} else {
		$divId = "platos";
	}
 */	
	$divId="platos";
	if ($cnt == 3 || $cnt >= 5) {
		$divId="platos3";
	}
	$mxCol=3;
	if($cnt == 2 || $cnt == 4){
		$mxCol=2;
	}
echo "<div id='" . $divId ."' >";
echo "<table>";
echo "<tr>";
	$cont=0;
	for($i = 0; $i < $cnt; $i++){
		$prod=$products[$i];
	//	echo "<td class='platotd' ><a href='".$prod->cat_url . "/" . $prod->url ."'>AQUI LAIMAGEN </a></td>";
		echo "<td class='platotd' ><a href='".$prod->cat_url . "/" . $prod->url ."'><img class='platoimg' src='" . $prod->img_path ."' /> </a></td>";
		$cont++;
		if ($cont % $mxCol ==0){
			echo "</tr>";
			echo "<tr>";
			for ($a = $i - ($mxCol - 1); $a <= $i; $a++){
				echo "<th align='justify'>" . $products[$a]->translation . "</th>";
			}
	                echo "</tr>";
	                echo "<tr>";
			$cont = 0;
		}
	}
	echo "</tr>";
	echo "</table>";
	echo "</div>";
	echo "<div class='botones'>";
	echo "<div class='boton' id='lista'>";
	echo "<a href='index'> <img src='./img/lista.png' /> </a>";
	echo "</div>";
            echo "          <div class=\"boton\" id=\"home\"  >";
            echo " <form action=\"index\" method=\"post\" name=\"langReset\">";
            echo '<input type="hidden" name="lreset" value="reset">';
            echo "</form>";
            echo "          <img src='./img/home.png' onclick='resetLanguages()' /> ";
            echo "          </div>";

	echo "</div>";
	echo "</div>";
	echo "</div>";



}
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
