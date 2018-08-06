<?php
include_once 'includes/headers.php';
include_once 'includes/adminAuthValidation.php';
include_once 'includes/libsheader.php';
$adminLink=conectarpdo($GLOBALS['MYSQL_BDNAME']);
$errors = '';
?>

<html>
<body>
<?php include_once 'includes/adminHeader.php'?>
<div style='position:relative;top:100px;'>
Wenas. Probando conexion
<?php 
$user = "kirsley";
if (esAdmin($user,$adminLink)){
    echo $user . "es admin <br />";
} else {
    echo $user . " No es admin <br />";
}
$user = "laura";
if (esAdmin($user,$adminLink)){
    echo $user . "es admin <br />";
} else {
    echo $user . " No es admin <br />";
}
$pass='tocdegralla';
echo verificaUserpdo($user,md5($pass),$adminLink). "\n";
?>

Seguro que estamos aqui, no?
</div>
</body>

<script type="text/javascript">
	<?php 
		//Zona de errores
		if ($errors != ""){
			echo "alert('$errors');";
		}
		desconectarpdo($adminLink);
	?>
</script>
</html>