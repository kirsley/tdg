<?php
include_once 'libs/headers.php';

function getAutor($rs){
	$row = mysqli_fetch_object($rs);
	$autor = new Autor($row->idAutor,$row->nomAutor,$row->cognomAutor);//La transformo a un objecte del tipus autor
	return $autor;
}
$queryLibros="SELECT * FROM llibres,element,autor WHERE element.idAutor = autor.idAutor and llibres.idLlibre = element.idElement";

$err="";
$link=conectar();
$idAutor=0;
if(isset($_POST['accio']) && ($_POST['accio']=='newAut')){
	$res= ejecutaQuery("SELECT * FROM autor WHERE nomAutor = '".$_POST['nomAutor']."' AND cognomAutor = '".$_POST['cognomAutor']."'", $link);
	if (mysqli_num_rows($res)==0){
		$query = "INSERT INTO autor (nomAutor,cognomAutor) VALUES ('".$_POST['nomAutor']."','".$_POST['cognomAutor']."')";
		if (ejecutaQuery($query,$link)){
			$idAutor=mysqli_insert_id($link);
		}else{
			$err=$err." Error al intentar fer la insersio";
		}
	}else{
		$err=" Aquest autor ja existeix";
	}
	$result = ejecutaQuery("SELECT * FROM autor WHERE nomAutor = '".$_POST['nomAutor']."' AND cognomAutor = '".$_POST['cognomAutor']."'", $link);
	//Recupero la fila (en forma d'objecte)
	$autor = mysqli_fetch_object($result,'Autor');
	
}elseif(isset($_POST['accio']) && ($_POST['accio']=='newLib')){

	$titol="";
	$altTitol="";
	$publYear="";
	$autorSel="";
	$numToms="";
	if (isset($_POST['titol'])){
		$titol=$_POST['titol'];
	}
	if (isset($_POST['altTitol'])){
		$altTitol=$_POST['altTitol'];
	}
	if (isset($_POST['publYear'])){
		$publYear=$_POST['publYear'];
	}
	if (isset($_POST['autorSel'])){
		$autorSel=$_POST['autorSel'];
		$idAutor=$autorSel;
	}
	if (isset($_POST['numToms'])){
		$numToms=$_POST['numToms'];
	}
	$idImatge=0;
	if(isset($_FILES['userfile'])){
		try {
			$idImatge=upload($link);
		}catch(Exception $e) {
			echo $e->getMessage();
			$err= $err." ".$e->getMessage();
		}
		if($idImatge <= 0){
			$idImatge=1;//Imatge "No_image"
		}
		if ($titol != "" && $autorSel !="" ){
			if ($publYear==""){
				$publYear=0;
			}
			$query="INSERT INTO element(titol,idAutor,idImatge,anyPublicacio,tipusElement) VALUES ('$titol','$autorSel','$idImatge','$publYear','1')";
			if (ejecutaQuery($query,$link)){
				$idElement=mysqli_insert_id($link);
				if (!($idElement) || ($idElement==0)){
					echo "Error al insertar el llibre a la taula Element, desfent l'accio ";
					$sqlDel="DELETE FROM imatges WHERE idImatge=".$idImatge;
					ejecutaQuery($query,$link);
				}else{
					$query="INSERT INTO llibres VALUES('$idElement','$altTitol','$numToms','0')";
					ejecutaQuery($query,$link);
					if (isset($_POST['classifica'])){
						$classi = $_POST['classifica'];
						$query="INSERT INTO classificacions(idElement,idClassificacio) VALUES ";
						$primer=True;
						foreach($classi as $idClass){
							if(!$primer){
								$query=$query.",";
							}else{
								$primer=False;
							}
							$query=$query."(".$idElement.",".$idClass.")";
						}
						ejecutaQuery($query,$link);
					}
				}
			}
		}
	}
}elseif(isset($_POST['accio']) && ($_POST['accio']=='elimina')){
	if(isset($_POST['idElim']) && $_POST['idElim']!="" ){
		$err=eliminaElement($_POST['idElim'], $link);
		$idAutor=$_POST['idAut'];
	}
}elseif(isset($_POST['accio']) && ($_POST['accio']=='elimTot')){
	if(isset($_POST['idAut']) && $_POST['idAut']!="" ){
		$idAutor=$_POST['idAut'];
		vaciaLibAutor($idAutor, $link);
	}
}


?>
<html>
<head>
	<title>Pagina Web MADWeb</title>
	<link href="css/style2.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='js/jquery.js'></script>
	<script type='text/javascript' src='js/main.js'></script>
	<script type='text/javascript' src='http://cdn.jquerytools.org/1.2.6/full/jquery.tools.min.js'></script>
	<script>
		function validaAutorForm(){
			if (($('input[name="nomAutor"]').val() != "") && ($('input[name="cognomAutor"]').val() != "")){
				$('form[name="nouAutor"]').submit();
			}else{
				if ($('input[name="nomAutor"]').val() == ""){
					$('input[name="nomAutor"]').css("backgroundColor","#FF9999");
				}else{
					$('input[name="nomAutor"]').css("backgroundColor","#99FF99");
				}
				if ($('input[name="cognomAutor"]').val() == ""){
					$('input[name="cognomAutor"]').css("backgroundColor","#FF9999");
				}else{
					$('input[name="cognomAutor"]').css("backgroundColor","#99FF99");
				}
			}
		}
		
		function validaLlibreForm(){
			var titol=$('input[name="titol"]');
			var altTitol=$('input[name="altTitol"]');
			var publYear=$('input[name="publYear"]');
			var numToms=$('input[name="numToms"]');
			var classif=$(".classifica:checkbox:checked");
			var ok=true;
			if (titol.val() == ""){
				titol.css("backgroundColor","#FF9999");
				ok=false;
			}else{
				titol.css("backgroundColor","#99FF99");
			}
			if (altTitol.val() == ""){
				altTitol.css("backgroundColor","#FEFFAA");
			}else{
				altTitol.css("backgroundColor","#99FF99");
			}
			if (publYear.val()=="" || isNaN(publYear.val())){
				publYear.css("backgroundColor","#FF9999");
				ok=false;
			}else{
				publYear.css("backgroundColor","#99FF99");
			}
			if (numToms.val()=="" | isNaN(numToms.val())){
				numToms.css("backgroundColor","#FF9999");
				ok=false;
			}else{
				numToms.css("backgroundColor","#99FF99");
			}
			if (classif.length <=0){
				alert("Seleccioni minim un tipus de classificacio");
				ok=false;
			}
			if (ok){
				$('form[name="nouLlibre"]').submit();
			}
		}
		function eliminaLlibre(idLibre){
			$("#idElim").val(idLibre);
			$("#accio").val("elimina");
			$('form[name="elAut"]').submit();
		}
		function eliminaTot(){
			$("#accio").val("elimTot");
			$('form[name="elAut"]').submit();	
		}
	</script>
</head>
<body class=index>
<div class="headerCont">
	<div class=headYmen>
		<div class="header">
			<div id='tLogo' ></div>
			<div id='titol' ></div>
		</div>
		<div class='main'>
			<table id='menu'>
				<tr>
					<th class='mainMnu' id='mnuMng' style="background-image:url('img/fonsOps.png');">Manga</th>
					<th class='mainMnu' id='mnuAni' onmouseover="sobre(this)"
						onmouseout="fora(this)" onclick="javascript:document.location='anime.php'" >Anime</th>
					<th class='mainMnu' id='mnuAni' onmouseover="sobre(this)" onmouseout="fora(this)"
							onclick="javascript:document.location='dorama.php'" >Dorama</th>
					<th class='mainMnu' id='mnuCer' onmouseover="sobre(this)"
						onmouseout="fora(this)" onclick="javascript:document.location='cerca.php'">Busqueda</th>
				</tr>
			</table>
		</div>
	</div> 
	<div class='cont'>
		<div class=autorsCont>
			<div class=autors><!-- Formulari Llistat D'Autors	-->
				<div id='llistaAutors'><?php 
					$autors=new Autors($link);
					?> 
					<table>
						<tr>
							<th>Seleccioni un autor</th>
						</tr>
						<tr>
							<td>
								<select name=autor onchange="actualizaSelect(this.value)">
								<?php
								foreach($autors->getAutors() as $autor){
									$selected='';
									if ($idAutor==0){
										$idAutor=$autor->getIdAutor();
									}
									if ($idAutor==$autor->getIdAutor()){
										$selected='selected';
									}
									echo "<option value=".$autor->getIdAutor()." ".$selected.">".$autor."</option>";
								
								}
								?>
								</select>
							</td>
						</tr>
					</table>
				</div>
			<!-- Formulari D'introduccio D'Autors	-->
				<div id='newAutor'>
					<form action='' method='post' name='nouAutor' ><input type='hidden' name=accio
						value='newAut' />
						<table>
							<tr>
								<th>Nom Autor:</th>
								<td><input name='nomAutor' type=text /></td>
							</tr>
							<tr>
								<th>Cognom Autor:</th>
								<td><input name='cognomAutor' type=text /></td>
							</tr>
							<tr>
								<td></td>
								<td><input  class='boto' type="button" value='Nou Autor' onclick='validaAutorForm()' /></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
		<div class='subLlib' id='subLlib'>
		<!-- Llistat Llibres Autor Sel·leccionat	-->
			<div id='llistaLlibresAutor'>
				<?php 
				$query="";
				if ($idAutor != 0){
					$query = $queryLibros." AND element.idAutor='".$idAutor."'";
					$libros = ejecutaQuery($query,$link);
					if($libros){
						$rows=mysqli_num_rows($libros);
						if($rows > 0){
							echo "<h2>Llibres del autor:</h2>";
							?>
					<form action='' method='post' name='elAut' >
					<input type='hidden' name=accio value='el' id='accio' />
					<input type='hidden' name=idElim value='-1' id='idElim' />
					<input type='hidden' name=idAut value='<?php echo $idAutor; ?>' id='idAut' />
					<table id='taulaAutors'>
						<tr>
							<th>Titol</th>
							<th>Nom Autor</th>
							<th>Any</th>
							<th colspan=2>Accio</th>
						</tr>
						<?php
						while ($row=mysqli_fetch_array($libros)){
							echo "<tr>
							<td>".$row['titol']."</td>
							<td>".$row["cognomAutor"]." ".$row["nomAutor"]."</td>
							<td>".$row['anyPublicacio']."</td>
							<td><img src='img/icono_lupa.gif' target=_blank height=20 onClick=\"window.open('fitxa.php?idLib=".$row['idLlibre']."', this.target, 'width=420,height=230'); return false;\" /></td>
							<td><img src='img/del.png' height=20 title='Elimina libro' onClick=eliminaLlibre(".$row['idElement'].") /> </td>
							</tr>";		
						}
						
						?>
						<tr>
							<td colspan=5 style="text-align:right;" ><img src='img/trash_canfull.png' height=20 title="Buidar tot" onclick='eliminaTot()' /> </td>
						</tr>
					</table>
					</form>
					<?php
						}else{
							echo "No hi ha Llibres d'aquest autor";
						}
					}
				}
				?>
			</div>
		<!-- Introduccio del Nou Llibre -->
			<div id='nwMngFmr' class='fmrManga'>
				<h2>Formulari Introducci&oacute; Dades Manga</h2>
				<FORM id='newManga' enctype='multipart/form-data' action=''
					method='POST' name='nouLlibre' ><input type='hidden' name=accio value='newLib' />
					<table id='nwMngFmr'>
						<tr>
							<th class='nwMngFmr' colspan=2>T&iacute;tol:</th>
							<td><input class='fmrMng' type='text' name='titol' /></td>
						</tr>
						<tr>
							<th class='nwMngFmr' colspan=2>T&iacute;tol Alternatiu (si en t&eacute;):</th>
							<td><input class='fmrMng' type='text' name='altTitol' /></td>
						</tr>
						<tr>
							<th class='nwMngFmr' colspan=2>Any Publicaci&oacute;:</th>
							<td><input class='fmrMng' type='text' name='publYear' /></td>
						</tr>
						<tr>
							<th class='nwMngFmr' colspan=2>N&uacute;mero de Toms:</th>
							<td><input class='fmrMng' type='text' name='numToms' /></td>
						</tr>
						<tr>
							<th class='nwMngFmr' colspan=2>Autor/a:</th>
							<td><SELECT class='fmrMng' NAME='autorSel' id='autorSel'>
							<?php
								echo $autors->total();
							foreach($autors->getAutors() as $autor){
								$selected='';
								if ($idAutor==0){
									$idAutor=$autor->getIdAutor();
								}
								if ($idAutor==$autor->getIdAutor()){
									$selected='selected';
								}
								echo "<option value=".$autor->getIdAutor()." ".$selected.">".$autor."</option>";
					
							}
							?>
							</select></td>
						</tr>
						<tr>
							<th class='nwMngFmr' colspan=2>Imatge (Si hi ha)</th>
							<td><input name='userfile' type='file' /></td>
						</tr>
						<tr>
							<th class='nwMngFmr' id='nwFmrCls' colspan=3>Classificacions:</th>
						</tr>
						<tr>
							<td colspan=3><?php 
							$classificacions=new Classificacions($link);
								
							$aux=0;
							echo "<table class='clasif'><tr>";
							foreach($classificacions->getClassificacions() as $cla){
					
								echo "<td class='inChCl'><input type='checkbox' value=".$cla->getIdClassificacio()." name='classifica[]' class='classifica'/></td><td class='txtCl'>".$cla."</td>";
								$aux++;
								if ($aux % 4 == 0){
									echo ("</tr><tr>");
								}
							}
							echo "</tr></table> ";
							?></td>
						</tr>
						<tr>
							<td colspan='2'><input class='boto' type='button' value='valida'
								onclick='validaLlibreForm()' /></td>
						</tr>
					</table>
				</FORM>
			</div>
		</div>
	</div>
</div>
<div class='error'>
							<?php
if ($err != ""){
	echo "Se han producido los siguientes errores: <BR />";
	echo $err;
}
?>
</div>
</body>
</html>
