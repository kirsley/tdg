<?php
	include_once '../libs/serveisHeads.php';
    
    if(isset($_GET['image_id']) && is_numeric($_GET['image_id'])) {
		$id = $_GET['image_id'];
		$link=conectar();
        // Recuperem la imatge
        $sql = "SELECT * FROM imatges WHERE idImatge=$id";
        $result = mysqli_query($link, $sql);
 		$datos =mysqli_fetch_row($result);
 		
 		header("Content-Type: $datos[1]");
        echo $datos[2];
 
        desconectar($link);
    }
?>