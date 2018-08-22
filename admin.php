<?php
    include_once 'includes/headers.php';
    include_once 'includes/adminAuthValidation.php';
    $adminLink=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    $errors = '';
?>

<html>
<head>
<?php
    include_once 'includes/libsheader.php';
?>
<title> Toc de Gralla - Administrador </title>
<script>
$(document).ready(function(){
        listCategories();
});

</script>
</head>
<body>
<?php include_once 'includes/adminHeader.php'?>
<div class="options">
        <div class="opcMen">
                <table>
                        <tr>
                                <td><div class="opcs" style="background-color:#fff7ac;"> Administrar Categorias </div></td>
                                <td><div class="opcs" onmouseover="sobre(this)"
                                                onmouseout="fora(this)" onclick="javascript:document.location='platos'"> Administrar Platos </div></td>
                        </tr>
                </table>
        </div>
</div>
<div class="menuContainer">
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
