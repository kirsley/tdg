<?php
	include_once '../libs/serveisHeads.php';

//recepcion de parametros
$idAutor=$_GET["idAutor"];

$link=conectar();
$queryLibros="SELECT * FROM llibres,element,autor WHERE element.idAutor = autor.idAutor and llibres.idLlibre = element.idElement";
echo "<div id='llistaLlibresAutor'>";
$query="";
if ($idAutor != 0){
	$query = $queryLibros." AND element.idAutor='".$idAutor."'";
	$libros = ejecutaQuery($query,$link);
	if($libros){
		$rows=mysqli_num_rows($libros);
		if($rows > 0){
			echo "<h2>Llibres del autor:</h2>";
			echo "<form action='index.php' method='POST' name='elAut' >
			<input type='hidden' name='accio' value='el' id='accio' />
			<input type='hidden' name='idElim' value='-1' id='idElim' />
			<input type='hidden' name='idAut' value=".$idAutor." id='idAut' />";
			echo "<table id='taulaAutors'>
			<tr>
			<th>Titol</th><th>Nom Autor</th><th>Any</th><th>Accio</th>
			</tr>";
			
			while ($row=mysqli_fetch_array($libros)){
				echo "<tr><td>".$row['titol']."</td><td>".$row["cognomAutor"]." ".$row["nomAutor"]."</td>
				<td>".$row['anyPublicacio']."</td>
				<td><a href='fitxa.php?idLib=".$row['idLlibre']."' target=_blank onClick=\"window.open(this.href, this.target, 'width=420,height=230'); return false;\"> <img src='img/icono_lupa.gif' height=20  />  </a></td>
				<td><img src='img/del.png' height=20 title='Elimina libro' onClick=eliminaLlibre(".$row['idElement'].") /> </td>
				</tr>";
			}
			echo "<tr>
					<td colspan=5 style='text-align:right;' ><img src='img/trash_canfull.png' height=20 title='Buidar tot' onclick='eliminaTot()' /> </td>
				</tr>";
			echo "</table>";
			echo "</form>";
		}else{
			echo "No hi ha Llibres d'aquest autor";
		}
	}
}
echo "</div>";
echo "<div id='nwMngFmr' class='fmrManga'>";
echo "<h2> Formulari Introducci&oacute; Dades Manga</h2>";

echo "<FORM id='newManga' enctype='multipart/form-data' action='' method='POST'>";
echo "<input type='hidden' name=accio value='newLib' />";
echo "<table id='nwMngFmr'>";
echo "<tr><th class='nwMngFmr' colspan=2> T&iacute;tol: </th><td><input class='fmrMng' type='text' name='titol' /></td>";
echo"</tr><tr><th class='nwMngFmr' colspan=2 > T&iacute;tol Alternatiu (si en t&eacute;): </th><td><input class='fmrMng' type='text' name='altTitol' /></td>";
echo"</tr>
<tr>
<th class='nwMngFmr' colspan=2> Any Publicaci&oacute;: </th><td><input class='fmrMng' type='text' name='publYear' /></td>
</tr>
<tr>
<th class='nwMngFmr' colspan=2> N&uacute;mero de Toms: </th><td><input class='fmrMng' type='text' name='numToms' /></td>
</tr>
<tr>
<th class='nwMngFmr' colspan=2> Autor/a: </th>
<td>";


$autors=new Autors($link);
echo "<SELECT class='fmrMng' NAME='autorSel' id='autorSel'>";
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

echo "</select>";
echo "</td></tr><tr>";


echo "<th class='nwMngFmr' colspan=2>Imatge (Si hi ha)</th><td><input name='userfile' type='file' /></td>";
echo "</tr><tr>	<th class='nwMngFmr' id='nwFmrCls' colspan=3>Classificacions:</th></tr>";
echo "<tr>
<td colspan=3>";

$classificacions=new Classificacions($link);
desconectar($link);

$aux=0;
echo "<table class='clasif'><tr>";
foreach($classificacions->getClassificacions() as $cla){
		
	echo "<td class='inChCl'><input type='checkbox' value=".$cla->getIdClassificacio()." name='classifica[]' /></td><td class='txtCl'>".$cla."</td>";
	$aux++;
	if ($aux % 4 == 0){
		echo ("</tr><tr>");
	}
}
echo "</tr></table> ";
echo "</td></tr><tr>";

echo "<td colspan='2'><input class='botonForm' type='button' value='valida' onclick='submit()' /></td></tr></table>";

echo "</FORM>";

echo "</div>";
?>
