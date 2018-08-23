<?php
    include_once 'includes/headers.php';
    include_once 'includes/adminAuthValidation.php';
    $adminLink=conectarpdo($GLOBALS['MYSQL_BDNAME']);
	if(isset($_POST['accio']) && $_POST['accio'] == 'newPlate'){
		$cat_id= $_POST['pltCateg'];
		$name = $_POST['pltName'];
		$url = strtolower(generateUrl( $name));
		$name =htmlChars($name);
		$imgPath=uploadImage($cat_id,$url);
		if (!$imgPath){
			$imgPath = 'uploads/no_image.jpg';
		}
	
                $languages=[];
                foreach(array_keys($_POST) as $akey){
                        if (substr($akey, 0, 4) === 'lang'){
                                $langId=substr($akey,4);
				$lang=htmlChars($_POST[$akey]);
				if ($lang) {
	                                $languages[$langId] = $lang ;
				} else {
					$languages[$langId] = $name;
				}
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
	listaPlatos(0);
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
		<div class='platList container' id='platList'>
		</div>
	<div>
</div>
<?php
                desconectarpdo($adminLink);
?>
</body>
</html>
