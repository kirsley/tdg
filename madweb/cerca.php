<?php
include_once 'libs/headers.php';
$style="style='display: none;'";
$styleCerca="style='display: block;'";
?>
<html>
<head>
<title>Pagina Web MADWeb</title>
<link href="css/style2.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='js/jquery.js'></script>
<script type='text/javascript' src='js/main.js'></script>
<script>
	function switchMode(){
		var titol=$("#nomCerca").val();
		if ($("#md").val() == "s"){
			$("#md").val("c");
			$("#cercaSimple").hide();
			$("#cercaCompl").fadeIn("slow");
		}else{
			$("#md").val("s");
			$("#cercaCompl").hide();
			$("#cercaSimple").fadeIn("slow");
			clearForm(document.formCerca);
		}
		$("#nomCerca").val(titol);
	}
	function novaCerca(){
		$("#resultados").hide();
		$("#cercador").fadeIn("slow");
		clearForm(document.formCerca);
		$("#md").val("s");
		$("#cercaCompl").hide();
		$("#cercaSimple").fadeIn("slow");
	}
	function cerca(){
		$("#cercador").hide();
		$("#resultados").fadeIn("slow");
		busca("");
	}

	function clearForm(oForm) {
		var i;
		var elements = oForm.elements;
		var mode=$("select[id='selCerc']").val();
		var quan=$("select[id='selQuan']").val();
		
		oForm.reset();
		for(i=0; i<elements.length; i++) {
			field_type = elements[i].type.toLowerCase();
			switch(field_type) {
			case "text":
		    case "password":
		    case "textarea":
		        elements[i].value = "";
		        break;
			case "radio":
			case "checkbox":
				if (elements[i].checked) {
					elements[i].checked = false;
				}
				break;
		    case "select-one":
		    case "select-multi":
		        elements[i].selectedIndex = -1;
		        break;
		    default:
		        break;
		    }
		}
		$("select[id='selCerc']").val(mode);
		$("select[id='selQuan']").val(quan);
	}
	
	//Genera la cadena GET pels camps del tipus 'checkbox'
	function getCadenaTipus(nomCamp){
		checkedCheckboxes=$("."+nomCamp+":checkbox:checked");
		var selectedValues="";
		for(var i=0;i<checkedCheckboxes.length;i++){
			selectedValues +=  "&"+nomCamp+"[]="+$(checkedCheckboxes[i]).val() ;
		}
		return selectedValues;
	}
	
//	//Per evitar click dret Ratolí
	/*document.oncontextmenu = function(){ 
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
	}*/
	// End -->
</script>
</head>
<body class=index>
	<div class="headerCont">
		<div class=headYmen>
			<div class="header">
				<div id='tLogo'></div>
				<div id='titol'></div>
			</div>
			<div class='main'>
				<table id='menu'>
					<tr>
						<th class='mainMnu' id='mnuMng' onmouseover="sobre(this)"
							onmouseout="fora(this)"
							onclick="javascript:document.location='index.php'">Manga</th>
						<th class='mainMnu' id='mnuAni' onmouseover="sobre(this)"
							onmouseout="fora(this)"
							onclick="javascript:document.location='anime.php'">Anime</th>
						<th class='mainMnu' id='mnuAni' onmouseover="sobre(this)" onmouseout="fora(this)"
							onclick="javascript:document.location='dorama.php'" >Dorama</th>
						<th class='mainMnu' id='mnuCer'
							style="background-image: url('img/fonsOps.png');">Busqueda</th>
					</tr>
				</table>
			</div>
		</div>
		<div class='cerca'>
			<div id='cercador' <?php echo $styleCerca; ?>>
				<h2>Par&agrave;metres de cerca:</h2>
				<form action=cerca.php method="POST" name="formCerca">
					<input type='hidden' name='md' value='s' id='md' /> <input
						type='hidden' name='ini' value='0' id='md' />
					<h4>Titol a Cercar:</h4>
					<select name="modeCerca" id="selCerc">
						<option value="conte" selected="selected">Cont&eacute;</option>
						<option value="inici">Comen&ccedil;a amb</option>
						<option value="fi">Acaba en</option>
					</select> <input name="titol" id="nomCerca" type="text"
						class="text" size="30" maxlength="150" value="" />
					<!-- onClick='cerca()' -->
					<input class='boto' type='button' value='cerca' onClick='cerca()' />
					<BR />

					<div id="cercaSimple">
						<!-- Cerca Simple Per Títol del element (Llibre,Anime,drama) -->
						<a id='switchCerca' onclick='switchMode()'> ==&gt; Cerca
							Avan&ccedil;ada </a>
					</div>
					<div id="cercaCompl">
						<h4>Es:</h4>
						<table>
							<tr>
								<?php 
		
								$link=conectar();
								$tipus=new CollecioTipus($link);
								foreach($tipus->getCollecioTipus() as $tip){
									echo "<td><input type='checkbox' name='tipusPubli[]' class='tipusPubli' value='".$tip->getIdTipus()."' />".$tip."</td>";
								}
								?>
							</tr>
						</table>
						<!-- Per any de publicacio -->
						<h4>Es va publicar:</h4>
						<select name="quan" class="selQuan" id='selQuan'>
							<option value="abans">Avan&ccedil; de:</option>
							<option value="despres">Despr&eacute;s de:</option>
							<option value="durant" selected>Durant l'any:</option>
						</select> <input type="text" name='anyPub' /> <br />
						<!-- Per Classificació/ons -->
						<h4>Es del tipus:</h4>
						<?php 
						$classificacions=new Classificacions($link);
						$aux=0;
						echo "<table class='clasif'><tr>";
						foreach($classificacions->getClassificacions() as $cla){
							echo "<td class='inChCl'><input type='checkbox' value=".$cla->getIdClassificacio()." name='classifica[]' class='classifica' /></td><td class='txtCl'>".$cla."</td>";
							$aux++;
							if ($aux % 4 == 0){
								echo ("</tr><tr>");
							}
						}
						echo "</tr></table> ";
						?>
						<a id='switchCerca' onclick='switchMode()'> ==&gt; Cerca Simple</a> <BR />
					</div>
				</form>
			</div>
			<div id='resultados' <?php echo $style; ?>>
				<div class='boto' id='novaCerca' onclick='novaCerca()'>Nova Cerca</div>
				<BR />
			</div>
		</div>
	</div>

</body>
</html>

