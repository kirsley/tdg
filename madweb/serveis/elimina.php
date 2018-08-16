<?php 
	include_once '../libs/serveisHeads.php';
	
	if(isset($_GET['idElem'])){	
		$delLink=conectar();
		$idElement=$_GET['idElem'];
		$cercaElemSql="SELECT idElement,tipusElement,idImatge FROM element e WHERE e.idElement=".$idElement;
		$res=ejecutaQuery($cercaElemSql, $delLink);
		$rows=mysqli_num_rows($res);
		if($rows==0){
			$row=mysqli_fetch_array($res);
			$idTipus=$row['tipusElement'];
			$idImatge=$row['idImatge'];
			//Recullo els Id's que necessitaré per eliminar-los de les taules on apareguin.
			
			
			
		}
	}
?>