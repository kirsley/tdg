<?php
    include_once 'includes/headers.php';
    include_once 'includes/adminAuthValidation.php';
    $adminLink=conectarpdo($GLOBALS['MYSQL_BDNAME']);
	if(isset($_POST['accio']) && $_POST['accio'] == 'newPlate'){
		$imgPath=uploadImage();
		if (!$imgPath){
			$imgPath = 'uploads/no_image.jpg';
		}
		$cat_id= $_POST['pltCateg'];
		$name = $_POST['pltName'];
		$url = strtolower(generateUrl( $name));
		$name =htmlChars($name);
                $languages=[];
                foreach(array_keys($_POST) as $akey){
                        if (substr($akey, 0, 4) === 'lang'){
                                $langId=substr($akey,4);
                                $languages[$langId] = htmlChars($_POST[$akey]) ;
                        }
                }
                insertPlate($adminLink,$cat_id,$name,$url,$languages,$imgPath);
	}
?>

<html>
<head>
<?php
    include_once 'includes/libsheader.php';
?>
<title> Toc de Gralla - Administrador </title>
<script>

$(document).ready(function(){
	get_platos();
});

	function guardarNuevo(){
        $('form[name="platForm"]').submit();
    }


</script>
</head>
<body>
<?php include_once 'includes/adminHeader.php'?>
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
<div class="menuContainer">
	<div class="pltMng" id="pltMng">
		<div class="newPlt container">
			<?php 
				include_once "newPlato.php"; 
			?>
		</div>
		<div class='platList container' id='platList' onclick='get_platos()'>
GET PLATOS
		</div>
	<div>
</div>
<?php
                desconectarpdo($adminLink);
?>
</body>
</html>
