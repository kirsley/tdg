<?php
include_once 'includes/headers.php';
include_once 'includes/adminAuthValidation.php';
include_once 'includes/libsheader.php';
$adminLink=conectarpdo($GLOBALS['MYSQL_BDNAME']);
$errors = '';


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
    //$langKeys=array_keys($languages);
}
?>

<html>
<head>
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
}
function acceptChanges(id){
        modifId="#modif" + id;
        acceptId="#accept" + id;
        $(acceptId).css('display','none');
        $(modifId).css('display','block');
}
function deleteCat(id){
	res = confirm("Eliminar categoria " + id + "?");
	if (res){
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
		<div class="addCat">
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
		<div class="listCat">
			<h2> Listado de Categorias </h2>
			<?php
				$categoryList=getCategoryListing2($adminLink) ;
				if (sizeof($categoryList) > 0) {
					echo "<table><tr>";
					echo "<th>ID</th><th>Url</th>";
					$languages=getLanguages($adminLink);
					foreach ($languages as $lang){
						echo "<th>" . $lang->lang . "</th>";
					}
					echo "<th colspan='2'>Acciones</th></tr>";
					$cont=0;
					foreach( $categoryList as $elem){
						echo "<tr><td>".$elem->id . "</td>";
						echo "<td>" . $elem->url . "</td>";
						foreach($elem->translations as $trans){
							echo "<td>" . $trans . "</td>";
						}
						echo "<td class='tdOpts'><img class='modifOpts' src='img/modif.png' oncLick='modificaCat(\"".$elem->id."\")' id='modif" . $elem->id . "' style='display:block;'/> <img class='modifOpts' src='img/accept.png' id='accept".$elem->id."' style ='display: none;' onclick='acceptChanges(\"".$elem->id."\")'/> </td>";
						echo "<td class='tdOpts'><img class='modifOpts' src='img/del.png' id='delete' onclick='deleteCat(\"" . $elem->id . "\")' /></td>";
						echo "</tr>";
					}
					$cont++;
					echo "</table>";
				}
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
