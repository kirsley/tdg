<?php
	/*include_once 'libs/headers.php';
	$cadenaBusqueda="?";
	$primer=true;
	foreach ($_GET as $clave => $valor){
		if($clave <> "ini"){
			if (!($primer) && !(is_array($valor))){
				$cadenaBusqueda.="&";
			}else{
				$primer=false;
			}
			if(is_array($valor)){
				foreach($valor as $key2 => $val2){
					$cadenaBusqueda.= "&".$clave."[]=".$val2;
				}
			}else{
				$cadenaBusqueda.= $clave."=".$valor;
			}
		}
	}
	$sqlInfoBase="SELECT * FROM element e,autor a,tipus t ";
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
	if (isset($_GET['ini']) && $_GET['ini'] != "" ){
		$ini=$_GET['ini'];
	}else{
		$ini=0;
	}
	/**
	 * $pas --> Variable que indica el numero de registros a mostrar
	 */
	$pas=1;
	
// 	mostraCerca($link, $sql, $ini, $pas);
	function mostraCerca($link,$sql,$ini,$pas){
		global $cadenaBusqueda;
		//Comprobo, primer que hi hagi algun resultat 
		$calcRows=mysqli_query($link, $sql);
		$tRows=0;
		if($calcRows){
			$tRows=mysqli_num_rows($calcRows); //Guardo el total de files a mostrar
		}
		if($tRows > 0){
			$sqlLimit=$sql." LIMIT ".$ini.",".$pas;
			$resultat=mysqli_query($link, $sqlLimit);
			if($resultat && mysqli_num_rows($resultat) >0){
				mostraTaula($link,$resultat);
				echo "<div class='pag'>";
				for($p=1;$p<=($tRows/$pas)+1;$p++){
					//$p--> Pagina Num
					$pagIni=($p*$pas) - $pas;
					if($pagIni<$tRows){
						$idIni="";
						if($pagIni == $ini){
							$idIni='ID=pActual';
							echo $p."&nbsp;";
						}else{
							echo "<a ".$idIni." onclick='proba(\"".$cadenaBusqueda."&ini=".$pagIni."\")'>".$p."</a> &nbsp;";
						}
					}
				}
				echo "</div>";
			}
		}
		echo "<div id='novaCerca' onclick='novaCerca()'> Nova Cerca</div> <BR />";
	}
	function mostraTaula($link,$result){
		$autors=new Autors($link);
		$tipus=new CollecioTipus($link);
		if($result){
			$rows=mysqli_num_rows($result);
			if($rows > 0){
				echo "<h2>Llista d'elements trobats</h2>";
				echo "<table><tr><th>Titol</th><th>Autor</th><th>Tipus de Publicacio</th><th>Any Publicacio</th><th>Accio</th></tr>";
				while ($row=mysqli_fetch_array($result)){
					echo "<tr><td>".$row['titol']."</td><td>".$autors->getAutor($row['idAutor'])."</td><td>".$tipus->getTipus($row['tipusElement'])."</td><td>".$row['anyPublicacio']."</td><td><a href='fitxa.php?idLib=".$row['idElement']."' target=_blank onClick=\"window.open(this.href, this.target, 'width=420,height=230'); return false;\"> <img src='img/icono_lupa.gif' height=20  /> </a></td></tr>";
				}
				echo "</table>";
			}else{
				echo "No s'han trobat elements que es corresponguin amb la descripci&oacute; aportada";
			}
		}
		desconectar($link);
	}
	
	
	// Dominio a comprobar
	$sitio = "172.20.1.89";
	// Puerto a comprobar, el web es el 80
	$puerto = 22;
	$fp = fsockopen($sitio,$puerto,$errno,$errstr,10);
	if(!$fp)
	{
		echo "No ha sido posible la conexi�n";
		// El modo de tratamiento del error puede ser el que se quiera, por ejemplo enviar un email.
	}else{
		echo "Conexi�n realizada con �xito.";
		fclose($fp);
	}
	
?>