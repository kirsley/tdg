<?php
	include_once '../libs/serveisHeads.php';
	
	$sqlInfoBase="SELECT DISTINCT (e.titol), e.idElement,e.anyPublicacio, a.idAutor, e.tipusElement FROM element e,autor a,tipus t ";
	$whereClause=" WHERE e.idAutor = a.idAutor AND e.tipusElement = t.idTipus";
	$sql="";
	$cerca=false;
	$style="style='display: none;'";
	$styleCerca="style='display: block;'";
	if (isset($_GET['md'])){
		$cerca=true;
		$style="style='display: block;'";
		$styleCerca="style='display: none;'";
		$sqlNom="";
		$nomMCerca="'%%'";
		if (isset($_GET['ini']) && $_GET['ini'] != "" ){
			$ini=$_GET['ini'];
		}else{
			$ini=0;
		}
		if ($_GET['md']=="s"){
			if (isset($_GET['titol']) && ($_GET['titol'] != "")){
				$nom = $_GET['titol'];
				if ($_GET['modeCerca']=="conte"){
					$nomMCerca="'%".$nom."%'";
				}elseif ($_GET['modeCerca']=="inici"){
					$nomMCerca="'".$nom."%'";
				}else{
					$nomMCerca="'%".$nom."'";
				}
				$sqlNom=" AND e.titol LIKE ".$nomMCerca;
			}
			$sql=$sqlInfoBase.$whereClause.$sqlNom;
		}elseif($_GET['md']=='c'){
			if (isset($_GET['titol']) && ($_GET['titol'] != "")){
				$nom = $_GET['titol'];
				if ($_GET['modeCerca']=="conte"){
					$nomMCerca="'%".$nom."%'";
				}elseif ($_GET['modeCerca']=="inici"){
					$nomMCerca="'".$nom."%'";
				}else{
					$nomMCerca="'%".$nom."'";
				}
				$sqlNom=" AND e.titol LIKE ".$nomMCerca;
			}
			$sqlTipPub="";
			$tpl="";
			if (isset($_GET['tipusPubli'])){
				$lstTip = $_GET['tipusPubli'];
				$sqlTipPub=$sqlTipPub." AND e.tipusElement IN ";
				$tpl="(";
				for($i=0;$i<sizeof($lstTip);$i++){
					$tpl=$tpl.$lstTip[$i];
					if ($i != (sizeof($lstTip)-1)){
						$tpl=$tpl.",";
					}
		    	}
		    	$tpl=$tpl.")";
			}
			$clsLst="";
			$sqlClas="";
			if(isset($_GET['classifica'])){
				$lstCla=$_GET['classifica'];
				$sqlInfoBase=$sqlInfoBase.",classificacions c";
				$whereClause=$whereClause." AND e.idElement = c.idElement";
				$sqlClas=$sqlClas." AND c.idClassificacio IN ";
				$clsLst="(";
				for($i=0;$i<sizeof($lstCla);$i++){
					$clsLst=$clsLst.$lstCla[$i];
					if ($i != (sizeof($lstCla)-1)){
						$clsLst=$clsLst.",";
					}
		    	}
		    	$clsLst=$clsLst.")";
			}
			$sqlTemps="";
			
			if(isset($_GET['anyPub']) && $_GET['anyPub'] != ""){
				$anyPub=$_GET['anyPub'];
				$quan=$_GET['quan'];
				if ($quan=="despres"){
					$sqlTemps=" AND e.anyPublicacio > ".$anyPub;
				}elseif($quan=="abans"){
					$sqlTemps=" AND e.anyPublicacio < ".$anyPub;
				}else{
					$sqlTemps=" AND e.anyPublicacio = ".$anyPub;
				}
			}
			
    		$sql=$sqlInfoBase.$whereClause.$sqlNom.$sqlTipPub.$tpl.$sqlClas.$clsLst.$sqlTemps;
		}else{
			$cerca=false;
		}
	}
	$link=conectar();
	
	/**
	 * $pas --> Variable que indica el numero de registros a mostrar
	 */
	$pas=10;
	function mostraCerca($link,$sql,$ini,$pas){
		//Comprobo, primer que hi hagi algun resultat 
		$sql = $sql." ORDER BY e.titol";
		$calcRows=mysqli_query($link, $sql);
		$tRows=0;
		if($calcRows){
			$tRows=mysqli_num_rows($calcRows); //Guardo el total de files a mostrar
		}
// 		echo $sql;
		if($tRows > 0){
			if (($tRows) % $pas != 0){
				list($a,$b)=explode(".",(($tRows) / $pas));
				$maxIni=($a * $pas);
			}else{
				$maxIni=$tRows - $pas;
			}
			if ($ini==0 && $ini == $maxIni){
				//Mostra Taula i prou
				mostraTaula($link,$calcRows);				
			}else{
				//mostra taula i pagina
				
				$sqlLimit=$sql." LIMIT ".$ini.",".$pas;
				echo $sqlLimit;
				$resultat=mysqli_query($link, $sqlLimit);
				if($resultat && mysqli_num_rows($resultat) >0){
					mostraTaula($link,$resultat);
					echo "<div class='pag'>";
					//Calculo el punt inicial maxim per fer les cerques
					/*
					 * Partint de la base que 
				 	 *		$tRows es el total d'elements a mostrar
					 * 		$pas es el nombre d'elements que es mostren per 'pagina'
					 * --------------------------------------------------------
					 * 		Si $tRows es divisible per $pas
					 * 			la ultima pagina ser� $tRows - $pas
					 * 		Si no ho es, 
					 * 			es calcula el nombre de Files senceres
					 * 			l'ultim inici = numFilesCompletes * $pas
					 */
					
					//Si Ini no es 0 (se suposa que hem passat de la primera pag
					//o
					// Si ini no es maxIni (no hi ha una unica pagina)
					if ($ini>0 || $ini != $maxIni){
						if($ini!=0 ){
							$pIniAnt=($ini- $pas);
							echo "<a class='fndNxtLst' onclick='busca(0)'><img src='img/first.png'></a> &nbsp;";
// 							<a class='fndNxtLst' onclick='busca(".$pIniAnt.")'>
							echo "<img src='img/previous.png' onclick='busca(".$pIniAnt.")' >";
						}
						for($p=1;$p<=($tRows/$pas)+1;$p++){
							//$p--> Pagina Num
							$pagIni=($p*$pas) - $pas;
							if($pagIni<$tRows){
								$idIni="";
								if($pagIni == $ini){
									$idIni='ID=pActual';
									echo $p."&nbsp;";
								}else{
									echo "<a ".$idIni." onclick='busca(".$pagIni.")'>".$p."</a> &nbsp;";
								}
							}
						}
						if(($ini != $maxIni)){
							$pIniSeg=($ini+$pas);
							echo "<a class='fndNxtLst' onclick='busca(".$pIniSeg.")'><img src='img/next.png'></a> &nbsp;";
							echo "<a class='fndNxtLst' onclick='busca(".$maxIni.")'><img src='img/last.png'></a> &nbsp;";
						}
					}
					echo "</div>";
				}
			}
		}else{
			echo "No s'han trobat elements que es corresponguin amb la descripci&oacute; aportada";
		}
		echo "<div class='boto' id='novaCerca' onclick='novaCerca()'> Nova Cerca</div> <BR />";
	}
	function mostraTaula($link,$result){
		$autors=new Autors($link);
		$tipus=new CollecioTipus($link);
		$rows=mysqli_num_rows($result);
		if($rows > 0){
			echo "<h2>Llista d'elements trobats</h2>";
			echo "<table id='taulaResCerca' ><tr><th>Titol</th><th>Autor</th><th>Tipus</th><th>Any Publicacio</th><th>Accio</th></tr>";
			while ($row=mysqli_fetch_array($result)){
				echo "<tr><td>".$row['titol']."</td><td>".$autors->getAutor($row['idAutor'])."</td><td>".$tipus->getTipus($row['tipusElement'])."</td><td>".$row['anyPublicacio']."</td><td>";
				echo " <img src='img/icono_lupa.gif' target=_blank height=20 onClick=\"window.open('fitxa.php?idLib=".$row['idElement']."', this.target, 'width=420,height=230'); return false;\" /></td></tr>";
			}
			echo "</table>";
		}else{
			echo "No s'han trobat elements que es corresponguin amb la descripci&oacute; aportada";
		}
		desconectar($link);
	}
	mostraCerca($link, $sql, $ini, $pas);
?>