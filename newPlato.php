<?php
    include_once 'includes/headers.php';
    include_once 'includes/adminAuthValidation.php';
    $adminDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    $fTitle="A&ntilde;adir Plato Nuevo";
    $fAccio="newPlate";
    $plato=0;
    $pName="";
    $pUrl="";
    $catId=0;
    if (isset($_GET['accio']) && $_GET['accio'] == 'modifPlat'){
	    $err=1;
	    $pid=-1;
	    $fAccio="modif";/**fullProduct Object ( [id] => 8 [name] => amanida hort [url] => amanida-hort [img_path] => uploads/de-lort.jpg [cat_id] => 14 [translations] => Array ( ) ) **/
	    if (isset($_GET['platoId']) && $_GET['platoId'] > 0){
		    $pid=$_GET['platoId'];
		    $plato=getFullPlato($adminDbh,$pid);
		    $err = 0;
	    }
	    if (!$err){
		    $fTitle="Modificar Producto";
		    $pName=$plato->name;
		    $pUrl=$plato->url;
		    $catId=$plato->cat_id;
	    } else {

echo  "<script type='text/javascript'>";
echo "window.close();";
echo "</script>";
	    }
    }
    echo "<h2>" . $fTitle . "</h2>";
    echo " <form enctype='multipart/form-data' method='POST' name='platForm' action='platos'>";
    echo " <input type='hidden' name='accio' value='" . $fAccio . "' />";
    echo "<table>";
    echo "<tr><th class='frmTitle' >Nombre corto </th>";
	echo "<td class='inputList'><input type='text' name='pltName' maxlength='40' value='".$pName."' /> </td>";/***/
	echo "</tr>";
    echo "<tr><th class='frmTitle'>Imagen</th> ";
	echo "<td class='inputList'><input name='pltImg' type='file' accept='image/*' /></td>";/***/
	echo "</tr>";
    echo "<tr><th class='frmTitle'>Categoria </th>";
    echo " <td class='inputList'>";
    echo "<select name='pltCateg'>";
    $categories= getCategoryLang($adminDbh,"esp",0);
    foreach ($categories as $cat){
	if($cat->id == $catId){
		echo "<option value='".$cat->id."' selected >" . $cat->descrip ."</option>";/***/
	}else{
		echo "<option value='".$cat->id."' >" . $cat->descrip ."</option>";/***/
	}
    }
    echo "</select>";
    echo " </td><tr>";
    echo "<tr><th colspan=2>Descricpi&oacute;n Por Idioma</th></tr>";
    if ( $plato ){
	    print_r($plato->translations);
	    foreach ($plato->translations as $elem){
		    var_dump($elem);/*
	      echo "<tr>";
        echo "<td class='frmTitle'>". $elem[0] . "</td>";
        echo "<td> <input name=\"lang" . $elem->id . "\" type=\"text\" value= \"".$elem[1]."\" /></td>";
	echo "</tr>";*/
	    }
    }
    $cont=0;
    $result=getLanguages($adminDbh);
    foreach ($result as $elem){
        echo "<tr>";
        echo "<td class='frmTitle'>". $elem->lang . "</td>";
        echo "<td> <input name=\"lang" . $elem->id . "\" type=\"text\" value= \"\" /></td>";/***/
    echo "</tr>";
    $cont++;
    }
    echo "<input type='hidden' name='totalLang' value='".$cont."' />";
    echo "<tr> <td></td><td class='inputList'><input class='boto' type='button' value='Agregar Producto' onClick='guardarNuevo()'></td>";
    echo " </tr>";
    echo "</table>";
    echo " </form>";

	desconectarpdo($adminDbh);
?>
