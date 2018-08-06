<?php
include_once 'includes/headers.php';
include_once 'includes/libsheader.php';
$adminLink=conectar($GLOBALS['MYSQL_BDNAME']);
$errors = '';
?>

<html>
<body>
<?php include_once 'includes/mainHeader.php'?>
Wenas. Probando conexion

Seguro que estamos aqui, no?
</body>

<script type="text/javascript">
	<?php 
		//Zona de errores
		if ($errors != ""){
			echo "alert('$errors');";
		}
		desconectar($adminLink);
	?>
</script>
</html>