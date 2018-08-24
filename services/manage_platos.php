<?php
    include_once 'headers.php';
    $adminDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    if(isset($_POST['accio']) && $_POST['accio'] = 'listPlat'){
	$cat_id = 0;
	$start = 0;
	if (isset($_POST['startP'])){
		$start = $_POST['startP'];
		$limit=15;
	}
        if (isset($_POST['cat_id'])){
                $cat_id = $_POST['cat_id'];
        }

	$cnt = countProd($adminDbh,$cat_id);
       	$products=getProdBasLstCat($adminDbh,$cat_id,$start,$limit);
	$response="";
       if($products){
       $response .= "<h2>Listado de Platos</h2>";
       $response .="<table>";
	
       $response .= "<tr><th>ID</th><th>Nombre corto</th>";
	$response .= "<th><select id='selectCat' name='pltCateg' onchange='filterCategory()'>";
	if (isset($cat_id) && $cat_id ===0){
        	$response .= "<option value='0' selected> <h2>Categoria </h2></option>";
	} else {
	        $response .= "<option value='0'> <h2>Categoria </h2></option>";
	}
    $categories= getCategoryLang($adminDbh,"esp",1);
    foreach ($categories as $cat){
	if($cat->id ===$cat_id){
        	$response .=  "<option value='".$cat->id."' selected >" . $cat->descrip ."</option>";
	}else {
	        $response .=  "<option value='".$cat->id."' >" . $cat->descrip ."</option>";
	}
    }
    $response .=  "</select></th>";

	$response .=  "<th>Imagen</th><th>Acciones</th></tr>";

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
	$response .= "<div id='myLink' onclick='listaPlatos(".$newEnd."," . $cat_id .")'>Atras</div>";
	 } 
	$response .= "</td><td> </td><td></td><td> </td><td>";
	if ($newStart <> $start) {
		$response .= "<div id='myLink' onclick='listaPlatos(".$newStart."," . $cat_id .")'>Siguiente</div>";
	}

	$response .= "</td></tr>";
	
       $response .= "</table>";
	echo $response;
	}
	desconectarpdo($adminDbh);

?>
