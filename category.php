<?php
include_once 'includes/headers.php';
$errors="";
    if (isset($_POST['lreset'])){
        unset($_SESSION['language']);
    }elseif (isset($_POST['language'])){
        $_SESSION['language'] = $_POST['language'];
    }
    $mainDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
	$category=explode(".",$_GET['cat'])[0];
	$cat_id=getCategory($mainDbh,$category);
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
<script>
	$(document).ready(function(){
		listaPlatos(0,<?= $cat_id ?>,'<?= $lang ?>');
	});
</script>
</head>
<body>
<?php 
include_once 'includes/mainHeader.php' ;
?>
<div id='cuerpo'>
    <div id='producto'>
        <div id='listaPlatosMain'>
        </div>
        <?php include_once "botonesCat.php" ?>
    </div>
</div>

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
