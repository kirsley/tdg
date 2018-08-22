<?php
    include_once 'headers.php';
    $adminDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    if(isset($_POST['accio']) && $_POST['accio'] = 'listPlat'){
       	$products=getProductListsBasic($adminDbh);
	$response="";
       if($products){
       $response .="<table>";
       $response .= "<tr><th>ID</th><th>Nombre corto</th><th>Categoria</th><th>Imagen</th><th>Acciones</th></tr>";

       foreach ($products as $prod) {
               $response .= "<tr><td>".$prod->id."</td><td>".$prod->name."</td><td>".$prod->translation."</td><td>".$prod->img_path."</td><td></td></tr>";
       }
       }
       $response .= "</table>";
	echo $response;
	}
	desconectarpdo($adminDbh);

?>
