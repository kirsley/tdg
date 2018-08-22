<?php
    include_once 'headers.php';
    $adminDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);

    if(isset($_POST['accio']) && ($_POST['accio']=='newCat')){
        $nomCateg=$_POST['nomCateg'];
        $contLang=$_POST['totalLang'];
        $url = strtolower(generateUrl( $nomCateg));
        $languages=[];
        for ($cont=1;$cont<=$contLang;$cont++){
            if (isset($_POST["lang" . $cont]) && $_POST["lang" . $cont] != ""){
                $languages[$cont] = htmlChars($_POST["lang" . $cont ]);
            } else {
                $languages[$cont] = htmlChars($nomCateg);
            }
        }
        insertCategory($adminDbh,$url,$languages);
    } elseif (isset($_POST['accio']) && ($_POST['accio']=='delCat')){
        if (isset($_POST['cat_id'])){
             removeCategory($adminDbh,$_POST['cat_id']);
        }
    } elseif (isset($_POST['accio']) && ($_POST['accio']=='modCat')){
        if (isset($_POST['cat_id'])){
        $catId=$_POST['cat_id'];
        $languages=[];
        foreach(array_keys($_POST) as $akey){
            if (substr($akey, 0, 4) === 'lang'){
                 $langId=substr($akey,4);
                 $languages[$langId] = $_POST[$akey] ;
            }
        }
        updateCategory($adminDbh,$catId,$languages);
        }
    } elseif ((isset($_GET['accio']) && ($_GET['accio']=='listCat'))) {
        $categoryLst="";
		$categoryLst .= "<h2> Listado de Categorias </h2>";
		$categoryList=getCategoryListing($adminDbh) ;
		if (sizeof($categoryList) > 0) {
		    $categoryLst .= "<table><tr>";
		    $categoryLst .= "<th>ID</th><th>Url</th>";
		    $languages=getLanguages($adminDbh);
		    foreach ($languages as $lang){
		        $categoryLst .= "<th>" . $lang->lang . "</th>";
		    }
		    $categoryLst .= "<th colspan='2'>Acciones</th></tr>";
		    $cont=0;
		    foreach( $categoryList as $elem){
		        $categoryLst .= "<tr id = 'cat" . $elem->id ."'><td>".$elem->id . "</td>";
		        $categoryLst .= "<td>" . $elem->url . "</td>";
		        foreach(array_keys($elem->translations) as $trans_id){
		            $categoryLst .= "<td><input class='inputEditable' name='lang" . $trans_id ."' type='text' value='" . $elem->translations[$trans_id] . "'  onkeypress=\"marcarCanvi('" .$elem->id ."')\" /> </td>";
		        }
		        $categoryLst .= "<td class='tdOpts'><img class='modifOpts' src='img/accept.png' id='accept".$elem->id."' style ='display: none;' onclick='acceptChanges(\"".$elem->id."\")'/> </td>";
		        $categoryLst .= "<td class='tdOpts'><img class='modifOpts' src='img/del.png' id='delete' onclick='deleteCat(\"" . $elem->id . "\")' /></td>";
		        $categoryLst .= "</tr>";
		    }
		    $cont++;
		    $categoryLst .= "</table>";
            echo $categoryLst;
		}
	}
    desconectarpdo($adminDbh);
 
?>
