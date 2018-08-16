<?php 
	include_once "libs/headers.php";
	$link=conectar();
	$idAutor=0;
	$queryLibros="SELECT * FROM llibres,element,autor WHERE element.idAutor = autor.idAutor and llibres.idLlibre = element.idElement";
	
?>

<html>
<head>
<title>Pagina Web MADWeb</title>
<link href="css/style2.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='js/jquery.js'></script>
<script type='text/javascript' src='js/main.js'></script>
<script>
	//Per evitar click dret Ratolí
	document.oncontextmenu = function(){ 
		return false;
		};
	//Per evitar Seleccio de text FORA de Inputs
	document.onselectstart=function(){
		if (event.srcElement.type != "text" && event.srcElement.type != "textarea" && event.srcElement.type != "password"){
			return false;
		}else{
			return true;
		}
	};
	if (window.sidebar){
		document.onmousedown=function(e){
			var obj=e.target;
			if (obj.tagName.toUpperCase() == "INPUT" || obj.tagName.toUpperCase() == "TEXTAREA" || obj.tagName.toUpperCase() == "PASSWORD"){
				return true;
			}else{	return false;
			}
		};
	}
	// End -->
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
						<th class='mainMnu' id='mnuMng' onmouseover="sobre(this)"
							onmouseout="fora(this)" onclick="javascript:document.location='index.php'" >Manga</th>
						<th class='mainMnu' id='mnuAni' style="background-image:url('img/fonsOps.png');" >Anime</th>
						<th class='mainMnu' id='mnuAni' onmouseover="sobre(this)" onmouseout="fora(this)"
							onclick="javascript:document.location='dorama.php'" >Dorama</th>
						<th class='mainMnu' id='mnuCer' onmouseover="sobre(this)" onmouseout="fora(this)"
							onclick="javascript:document.location='cerca.php'" >Busqueda</th>
					</tr>
				</table>
			</div>
		</div>
		<div class='cont' id='enConstr'>
			<div id='animTit'>
			</div>
			<div class='constr'>
				
			</div>
		</div>
	</div>
</body>
</html>