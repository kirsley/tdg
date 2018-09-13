<?php
    include_once 'headers.php';
    
    $adminDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    if (isset($_POST['accio']) && $_POST['accio'] == 'listPlat'){
    	$cat_id = 0;
    	$start = 0;
    	if (isset($_POST['startP'])){
    		$start = $_POST['startP'];
    		$limit=10;
    	}
            if (isset($_POST['cat_id'])){
                    $cat_id = $_POST['cat_id'];
            }
    
    	$cnt = countProd($adminDbh,$cat_id);
        $products=getProdBasLstCat($adminDbh,$cat_id,$start,$limit);
    	$response="";
           if($products){
           $response .= "<div class='titular'><div id='plListTlt'><h2>Listado de Platos</h2></div>";
           $response .= "<div id='modifTlt'><img src='img/modif.png' onclick='listaPlatos(0)' /></div></div>";
           $response .="<table>";
    	
           $response .= "<tr><th><input type='checkbox' id='selAll' onclick='selectAllPlatos()'/></th><th>Nombre corto</th>";
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
		   $response .= "<tr><td><input type='checkbox' name='platos' class='platoSel' onclick='showHideDelOpt()' value='".$prod->id."' /></td>";
		   $response .= "<td>".$prod->name."</td><td>".$prod->cat_url."</td><td>".$prod->img_path."</td>";
		   $response .= "<td><a href='modifPlato.php?accio=modifPlat&platoId=".$prod->id."' target=_blank onClick=\"window.open(this.href, this.target,'toolbar=no,resizable=no, width=340,height=360'); return false;\"> <img src='img/icono_lupa.gif' height=20  /> </a> ";
		   $response .= "<img class='modifOpts' src='img/del.png' id='delete' onclick='deletePlato(\"" . $prod->id . "\")' style='height:18px;' /></td></tr>";
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
        $response .= "<div id='delPlatos' style='display:none' onclick='deleteSelPlatos()'>Eliminar</div>";
    	$response .= "</td></tr>";
    	
           $response .= "</table>";
    	echo $response;
    } elseif(isset($_POST['accio']) && $_POST['accio'] == 'delPlatos'){
        $platos=[];
        $cont=0;
        foreach(array_keys($_POST) as $akey){
            if (substr($akey, 0, 5) === 'plato'){
                $platos[$cont]=$_POST[$akey];
                $cont++;
            }
        }
        echo deletePlatos($adminDbh,$platos);
    } elseif (isset($_POST['accio']) && $_POST['accio'] == 'newPlate'){
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
        
        insertPlate($adminDbh,$cat_id,$name,$url,$languages,$imgPath);
    }
    
	desconectarpdo($adminDbh);

?>
