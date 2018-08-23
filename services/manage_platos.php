<?php
    include_once 'headers.php';
    $adminDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    if(isset($_POST['accio']) && $_POST['accio'] = 'listPlat'){
	$cat_id = 0;
	$start = 0;
	if (isset($_POST['startP'])){
		$start = $_POST['startP'];
		$limit=12;
	}
	$cnt = countProd($adminDbh,$cat_id);
       	$products=getProdBasLstCat($adminDbh,$cat_id,$start,$limit);
	$response="";
       if($products){
       $response .= "<h2>Listado de Platos</h2>";
       $response .="<table>";
       $response .= "<tr><th>ID</th><th>Nombre corto</th><th>Categoria</th><th>Imagen</th><th>Acciones</th></tr>";

       foreach ($products as $prod) {
               $response .= "<tr><td>".$prod->id."</td><td>".$prod->name."</td><td>".$prod->translation."</td><td>".$prod->img_path."</td><td></td></tr>";
       	}
       }
	if (($start + $limit) < $cnt){
        	$newStart = $start + $limit;
	} else {
        	$newStart = $start;
	}	
	$newEnd = $start - $limit;
       $response .= "<tr><td>";
	if ($newEnd>=0){
	$response .= "<div id='myLink' onclick='listaPlatos(".$newEnd.")'>Atras</div>";
	 } 
	$response .= "</td> <td> </td><td></td><td> </td><td>";
	if ($newStart <> $start) {
		$response .= "<div id='myLink' onclick='listaPlatos(".$newStart.")'>Siguiente</div>";
	}

	$response .= "</td></tr>";
	
       $response .= "</table>";
	echo $response;
	}
	desconectarpdo($adminDbh);

?>
