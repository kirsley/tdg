<?php 
	include_once 'libs/headers.php';
	
	$queryLibros="SELECT * FROM llibres,element,autor WHERE element.idAutor = autor.idAutor and llibres.idLlibre = element.idElement";
	$queryAutors="SELECT * FROM autor";
	$idLibro=-1;
	if (isset($_GET['idLib']) && $_GET['idLib'] != ""){
		$idLibro=$_GET['idLib'];
	}
	$titol="Fitxa del Llibre no trobada";
	if($idLibro>0){
		$link=conectar();
		$query=$queryLibros." AND llibres.idLlibre='".$idLibro."';";
		$libro=mysqli_query( $link, $query);
		if($libro){
			$row=mysqli_fetch_array($libro);
			if($row['titol']){
				$titol="Fitxa de ".$row['titol'];
			}else{
				$idLibro=-1;
			}
		}
	}
?>
<html>
<head>
	<title>	<?php echo $titol;?></title>
<link href="css/style2.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='js/jquery.js'></script>
<script type='text/javascript' src='js/main.js'></script>
</head>
<body>
	<div class='fitxaFons'>
	<?php 
	if($idLibro>0){
		$classificacions=new Classificacions($link);
		?>
		<table class='fitxa'>
		<tr>
			<th rowspan=5 width='100'><img src='serveis/view.php?image_id=<?php echo $row['idImatge']; ?>' WIDTH='100' /></th>
			<th width=121>Titol</th><td><?php echo $row['titol']; ?></td>
		</tr>
		<?php 
		if ($row['titolAlternatiu']){
			echo "<tr><th>Titol Alternatiu</th><td>".$row['titolAlternatiu']."</td></tr>";
		}else{
			echo "<tr><th>Titol Alternatiu</th><td>&nbsp;</td></tr>";
		}
		?>
		<tr>
			<th>Autor</th>
			<td><?php echo $row["cognomAutor"]." ".$row["nomAutor"]; ?></td>
		</tr>
		<tr>
			<th>Any Publicacio</th>
			<td><?php echo $row['anyPublicacio']; ?></td>
		</tr>
		<tr>
			<th>Num de Toms</th>
			<td><?php echo $row['numToms']; ?></td></tr>
		<tr>
			<th colspan=3> Categories Assignades: </th>
		</tr>
		<tr>
			<th colspan=3>
			<?php 
			$classifSQL="SELECT * from classificacions WHERE idElement = '".$idLibro."'";
			$clasifRes=ejecutaQuery($classifSQL, $link);
			if ($clasifRes){
				$rows=mysqli_num_rows($clasifRes);
				if ($rows >0){
					echo "<table id='fclList' ><tr>";
					$i=0;
					$r=0;
					while ($classiObj = mysqli_fetch_object($clasifRes)){
						if ($i>0 && ($i % 4) == 0){
							echo "</tr><tr>";
							$r++;
						}
						$i++;
						$classificacio=$classificacions->getClassificacio($classiObj->idClassificacio);
						echo "<td>".$classificacio."</td>";
					}
					if (($i % 4)!= 0 && $r > 0){
						echo "<td colspan=".(4 - ($i % 4)).">&nbsp</td>";
					}
					echo "</tr></table>";
				}
			}
			desconectar($link);
			?>
			</th>
		</tr>
	</table>
	<?php 
	}else{
		echo "La fitxa del llibre que busca no consta a la base de dades, <br />o ha accedit a aquest enlla&ccedil;directament";
	}
	
	?>
	</div>
</body>
</html>
