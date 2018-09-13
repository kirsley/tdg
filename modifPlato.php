<?php
    include_once 'includes/headers.php';
    include_once 'includes/adminAuthValidation.php';
    $modifDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
$modificado = 0;
if (isset($_POST['accio']) && $_POST['accio']=='modif'){
               // print_r($_POST);
                $pid=$_POST['plId'];
                $cat_id= $_POST['pltCateg'];
                $name = $_POST['pltName'];
                $url = strtolower(generateUrl( $name));
                $name =htmlChars($name);
                $imgPath=uploadImage($cat_id,$url);
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
                modificarPlato($modifDbh,$pid,$cat_id,$name,$url,$languages,$imgPath);
		$modificado=1;

        }
	desconectarpdo($modifDbh);
?>
<html>
<head>
<script>
function guardarCambios(){
	$('form[name="platForm"]').submit();
}
</script>
</head>
<body>
<?php
include_once 'includes/libsheader.php';
if($modificado){

		echo "<div onclick='self.close()'>CERRAR</div>";
		echo "<script>setTimeout('self.close();',1);</script>";
}else{
                echo ' <div class="newPlt container">';
                                include_once "newPlato.php";
                echo "</div>";
}
?>
</body>
</html>
