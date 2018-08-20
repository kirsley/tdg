<?php
    include_once 'includes/headers.php';
    include_once 'includes/adminAuthValidation.php';
    $adminLink=conectarpdo($GLOBALS['MYSQL_BDNAME']);
	if(isset($_POST['accio'])){
		$imgPath=uploadImage();
		if ($imgPath){
			echo"fichero subido en " . $imgPath;
		} else {
			echo "fichero no subido";
		}
		//Array ( [accio] => newPlate [pltName] => Patatas Bravas [pltCateg] => 4 [lang1] => Patatas Bravas hechas con nuestra Salsa Casera [lang2] => Patates braves acompanyades de la nostra salsa casolana [lang28] => Chip potatoes with our won Homemade Sauce [totalLang] => 3 )
		print_r($_POST);
	}
?>

<html>
<head>
<?php
    include_once 'includes/libsheader.php';
?>
<title> Toc de Gralla - Administrador </title>
<script>
	function guardarNuevo(){
        $('form[name="platForm"]').submit();
    }


</script>
</head>
<body>
<?php //include_once 'includes/adminHeader.php'?>
<div class="options">
        <div class="opcMen">
                <table>
                        <tr>
                                <td><div class="opcs" onmouseover="sobre(this)" onmouseout="fora(this)" onclick="javascript:document.location='admin'"> Administrar Categorias </div></td>
                                <td><div class="opcs"  style="background-color:#fff7ac;"> Administrar Platos </div></td>
                        </tr>
                </table>
        </div>
</div>
<!--<div class='button' onclick='categoryList();'> Categorias </div>
<div id='listCat2'>
</div>-->
<div class="menuContainer">
	<div class="manage" id="pltMng">
		<div class="newPlt container">
			<?php 
				include_once "newPlato.php"; 
			?>
		</div>
		<div class='platList container'>
			<table>
			<tr><th>ID</th><th>Nombre corto</th><th>Categoria</th><th>Imagen</th><th>Acciones</th></tr>
			</table>
		</div>
	<div>
</div>
<?php
                desconectarpdo($adminLink);
?>
</body>
</html>
