<?php

//Funciones de validacion de datos

function ejecutaQuery($query, $link){
	$busca = mysqli_query($link,$query);
	return $busca;
}
/**
 * FunciÃ³n para hallar nÃºmeros
 * @param unknown_type $val
 * @return boolean
 */
function esNumero($val){
	$a=preg_match_all("/[\D]/",$val,$lista); //Numero de veces que aparece un valor no numerico
	$b=0;
	if ( $a >0 ){
		$b=preg_match("/./",$val,$lista);
	}
	$a=$a-$b;
	return $a==0;
}

/**
 * Funcion para hallar un entero
 * @param unknown_type $val
 * @return boolean
 */
function esEntero($val){
	return preg_match_all("/[\D]/",$val,$l)==0;
}

/**
 * Funcion para controlar el valor recibido segun sea el tipo de dato
 * @param String $text Texto a validar
 * @param String $tipo Numerico o Cadena de texto
 * @return Cierto o Falso segun sea valido o no
 */
function validarInput( $text , $tipo){
	if ($tipo=='string' ){
		if ($text!='' && strlen($text) != 0){
			$valido=true;
		}else{
			$valido=false;
		}
	}else{
		if (esEntero($text) && strlen($text) != 0){
			$valido=true;
		}else{
			$valido=false;
		}
	}
	return $valido;
}

/**
 * Limpia un string preparandolo para utilizarlo en una consulta SQL
 * @param $value Cadena con codigo a insertar en sentencias mysql
 * @return $value string limpio de sentencias sql
 */
function limpiar($value){
	$value=str_replace("'","",$value);
	$value=str_replace(";","",$value);
	$value=str_replace("&","",$value);
	$value=str_replace("SELECT","",$value);
	$value=str_replace("DELETE","",$value);
	$value=str_replace("UPDATE","",$value);
	$value=str_replace("INSERT","",$value);
	$value=str_replace("DROP","",$value);


	$value = trim(htmlentities($value)); // Evita introducciÃ³n cÃ³digo HTML

	if (get_magic_quotes_gpc()) {	// quita los caracteres escapados
		$value = stripslashes($value);
	}
	return $value;
}

//Funciones de acceso a Base de Datos

/**
 * Funci&oacute;n para establecer la conexi&oacute;n con la base de datos
 * @return $link enlace de conexi&oacute;n con base de datos
 */
function conectar(){
	$ini_array = parse_ini_file("config.ini");
	$ip=$ini_array['MYSQL_IP'];
	$user=$ini_array['MYSQL_USER'];
	$pass=$ini_array['MYSQL_PASSWORD'];
	$dbname=$ini_array['MYSQL_BDNAME'];
	$link=mysqli_connect($ip,$user,$pass,$dbname);
	if ( ! $link ){
		echo "Error al intentar conectar a mysql";
	}
	return $link;
}

/**
 * Funci&oacute;n para terminar correctamente la conexi&oacute;n con la base de datos
 * @param $link enlace de conexi&oacute;n
 */
function desconectar($link){
	mysqli_close($link);
}

/**
 * Carga una imatge a la BD.
 * @return 	-1 --> Si la imatge no esta com a parametre post <br />
 * 			-2 --> Si es massa gran<br />
 * 			Id --> de la imatge inserida (Si tot es correcte)		
 */
function upload($link){
	$maxsize=10000000;
	$idImg=-1;
	if(is_uploaded_file($_FILES['userfile']['tmp_name'])) {
		// Comprobem que el tamany sigui  menor al maxim
		if($_FILES['userfile']['size'] < $maxsize){
			// prepare the image for insertion
			$imgData =addslashes (file_get_contents($_FILES['userfile']['tmp_name']));

			// Recollir el tamany de la imatge i el tipus
			$size = getimagesize($_FILES['userfile']['tmp_name']);

			$sql = "INSERT INTO imatges
					( tipusImatge ,imatge, tamanyImatge, image_ctgy, nomImatge)
					VALUES
					('{$size['mime']}', '{$imgData}', '{$size[3]}','', '{$_FILES['userfile']['name']}')";
			// insert the image
			if(!mysqli_query($link,$sql)) {
				$idImg=mysqli_error($link);
				print_r($idImg);
			}else{
				$idImg=mysqli_insert_id($link);
			}
		}else {
			// Si es superior al tamany establert com a maxim
			$idImg=-2;
		}
	}
	return $idImg;
}

function eliminaElement($id,$link){
	
	//Obtenir els id's que fan referencia a una clau foranea
	$sqlGetInfos="SELECT idImatge,tipusElement FROM element WHERE idElement=".$id;
	$res=ejecutaQuery($sqlGetInfos, $link);
	if(mysqli_num_rows($res)== 1){
		$row=mysqli_fetch_array($res);
		$idTipus=$row['tipusElement'];
		$idImatge=$row['idImatge'];
		//Elimina classificacions
		$sqlDel="DELETE FROM classificacions WHERE idElement=".$id;
		$ok=false;
		$ok=ejecutaQuery($sqlDel, $link);
		if($ok){
			if($idTipus==1){
				$sqlDel="DELETE FROM llibres WHERE idLlibre=".$id;
			}else{
				$sqlDel="DELETE FROM serie WHERE idSerie=".$id;
			}
			$ok=false;
			$ok=ejecutaQuery($sqlDel, $link);
			if($ok){
				$sqlDel="DELETE FROM element WHERE idElement=".$id;
				$ok=ejecutaQuery($sqlDel, $link);
				if ($ok){
					if($idImatge != 1){
						$sqlDel="DELETE FROM imatges WHERE idImatge=".$idImatge;
						$ok=false;
						$ok=ejecutaQuery($sqlDel, $link);
					}
				}
			}
		}
		if($ok){
			return "";
		}else{
			return mysqli_error($link);
		}
	}
	
}
/**
 * Elimina, unicament, els Llibres del Autor indicat. En cas de tenir altres tipus d'elements dins
 * de l'entitat element, no els eliminarà
 * @param int $idAut --> Id del Autor a Eliminar
 * @param enllaç $link --> Enllaç de la conexió a la bd
 */
function vaciaLibAutor($idAut,$link){
	$getElemSQL="SELECT idElement FROM element e,llibres ll WHERE e.idElement = ll.idLlibre AND idAutor=".$idAut;
	$libros=ejecutaQuery($getElemSQL, $link);
	$rows=mysqli_num_rows($libros);
	if($rows >0){
		while($row=mysqli_fetch_array($libros)){
			$res=eliminaElement($row['idElement'], $link);
			if($res!=""){
				echo $res;
				break;
			}
		}
	}

}

?>
