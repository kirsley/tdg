<?php
    include_once 'includes/headers.php';
    if (isset($_POST['lreset'])){
        unset($_SESSION['language']);
    }elseif (isset($_POST['language'])){
        $_SESSION['language'] = $_POST['language'];
    }
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
<script>
	function setLanguage(idioma){
		$('input[name="language"]').val(idioma);
		$('form[name="langForm"]').submit();
	}
	function resetLanguages(){
		$('form[name="langReset"]').submit();
		
	}

	$(document).ready(function(){
		listaCategorias(0,'<?= $lang ?>');
	});
</script>
</head>
<body>
<?php include_once 'includes/mainHeader.php' ?>


	<?php
	if (!$lang){
	    echo "<div id='indice'>";
	echo '<div id="langMen">';
    echo '<form action="" method="post" name="langForm">';
    echo "<div class=\"bandera\" id=\"cat\"><img src=\"img/cat-eng.png\" onclick=\"setLanguage('cat')\" /></div>";
    echo "<div class=\"bandera\" id=\"cast\"><img src=\"img/esp-eng.png\" onclick=\"setLanguage('esp')\" /></div>";
    echo "<div class=\"bandera\" id=\"eng\"><img src=\"img/ingles.png\" onclick=\"setLanguage('eng')\" /></div>";
    echo '<input type="hidden" name="language" value="">';
	echo "</form>";
	echo "</div>";
	echo "</div>";
	} else {
		/*
	    $dbh=conectarpdo('tdg');
	    $categories= getCategoryLang($dbh,$lang,0);//TODO Eliminar esta linea y descomentar la siguiente
*/
	    //$categories= getCategoryLang($dbh,$lang,1); //Para que solo muestre las que tienen algo
	    echo "<div id=\"cuerpo\">";
	    echo "	    <div id=\"opciones\">";
/*	    echo "	    	<div id=\"menu\">";
	    echo "	    		<table >";
	    echo "				    <tr>";
	    $cont=0;
	    foreach ($categories as $cat){
	        if ($cont % 2 == 0){
	            echo "<tr>";
	            echo "<td> <div class=\"opcMenu\" onclick=\"window.location.href='" . $cat->url . "'\"> <div class='inText' >" . $cat->descrip . "</div> </div></td>";
	        } else {
	            echo "<td> <div class=\"opcMenu\" onclick=\"window.location.href='" . $cat->url . "'\"> <div class='inText' >" . $cat->descrip . "</div> </div></td>";
	            echo "</tr>";
	        }
	        $cont = $cont + 1;
	    }
	    if ($cont % 2 == 1){
	    	echo "</tr>";
	    }

	    echo "	    		</table>";
	    echo "	    	</div>";*/
	    echo "	    </div>";
	    include_once "botones.php";
	    echo "</div>";
	    
	   // desconectarpdo($dbh);
	}
	?>

</body>
</html>
