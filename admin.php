<?php
    include_once 'includes/headers.php';
    include_once 'includes/adminAuthValidation.php';
    include_once 'includes/libsheader.php';
    $adminLink=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    $errors = '';
//TODO migrate this to AJAX
//TODO determine which libraries are needed

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
	    insertCategory($adminLink,$url,$languages);
	} elseif (isset($_GET['accio']) && ($_GET['accio']=='delCat')){
		if (isset($_GET['cat_id'])){
			removeCategory($adminLink,$_GET['cat_id']);
		}
	} elseif (isset($_GET['accio']) && ($_GET['accio']=='modCat')){
		if (isset($_GET['cat_id'])){
		$catId=$_GET['cat_id'];
		$languages=[];
		foreach(array_keys($_GET) as $akey){
			if (substr($akey, 0, 4) === 'lang'){
				$langId=substr($akey,4);
				$languages[$langId] = $_GET[$akey] ;
			}
		}
		updateCategory($adminLink,$catId,$languages);
		}
	}
?>

<html>
<head>
<title> Toc de Gralla - Administrador </title>
<script>
    function validaCategoria(){
	    if (($('input[name="nomCateg"]').val() != "")){
			$('form[name="formCat"]').submit();
		}else{
					$('input[id="nomCateg2"]').css("backgroundColor","#FF9999");
		}
	}

    function modificaCat(id){
	    modifId="#modif" + id;
    	acceptId="#accept" + id;
    	$(modifId).css('display','none');
    	$(acceptId).css('display','block');
	    querylist="accio=modCat&cat_id="+id;
    	$("#cat"+ id).find("input").each(function () {
	    	querylist = querylist + "&" + $(this).prop('name') + "=" + encodeURIComponent($(this).val());
		    });
    	document.location='admin?' + querylist;
    }

    function deleteCat(id){
    	res = confirm("Eliminar categoria " + id + "?");
	    if (res){
		    document.location='admin?accio=delCat&cat_id='+ id ;
    		//se Procede con el Eliminado
	    }
    }
</script>
</head>
<body>
<?php include_once 'includes/adminHeader.php'?>
<div class="menuContainer">
	<div class="opcMen">
		<table>
			<tr>
				<td><div class="opcs"> Administrar Categorias </div></td>
				<td><div class="opcs"> Administrar Platos </div></td>
			</tr>
		</table>
	</div>
	<div class="manage" id="catMang">
		<div class="container addCat">
		<h2> A&ntilde;adir categoria nueva </h2>
		<form action="admin" method="POST" name="formCat">
			<input type='hidden' name=accio	value='newCat' />
			<table>
				<tr><th>Categoria</th>
				<td><input name="nomCateg" id="nomCateg2" type="text" class="text" size="30" maxlength="150" value="" /></td>
				</tr>
				<tr>
				<th colspan=2> A&ntilde;ade la Traducci&oacute;n</th>
				</tr>
					<?php 
					$cont=0;
				$result=getLanguages($adminLink);
				foreach ($result as $elem){
					echo "<tr>";
					echo "<td>". $elem->lang . "</td>";
					echo "<td> <input name=\"lang" . $elem->id . "\" type=\"text\" value= \"\" /></td>";
                            echo "</tr>";
                            $cont++;
				}
				echo "<input type='hidden' name='totalLang' value='".$cont."' />";
			?>
                <tr><td></td><td><input class='boto' type='button' value='Agregar Categoria' onClick='validaCategoria()' /></td>
			</table>
		</form>
		</div>
		<div class="container listCat" id="listCat">
			<?php
			     include_once 'includes/category_list.php';
			 ?>
		</div>
	</div>
	
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
