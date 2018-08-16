<?php
	include_once 'libs/headers.php';
	$link=conectar(); 
	$idImatge=0;
	$err="";
	if(isset($_FILES['userfile'])){
		try {
			$idImatge=upload($link);
		}catch(Exception $e) {
			echo $e->getMessage();
			$err= $err." ".$e->getMessage();
		}
	}
?>
<html>
<body>
	<form action="novaImatge.php" method=POST >
		<input name='userfile' type='file' />
		<input type=submit />
	</form>
	<?php 
		echo $idImatge;
		echo $err;
	?>
</body>
</html>