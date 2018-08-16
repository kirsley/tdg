function actualizaSelect(idAutor) {
	mostraAutor(idAutor);
}
function mostraAutor(idAutor) {
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("subLlib").innerHTML = xmlhttp.responseText;
		}
	};

	xmlhttp.open("GET", "serveis/mangaService.php?idAutor=" + idAutor, true);
	xmlhttp.send();
}
function sobre(elem) {
	elem.style.backgroundImage = "url('img/fonsOps.png')";
}
function fora(elem) {
	elem.style.backgroundImage = "";
}

function busca(cadCerca) {
	var cadena;
	iniCerca = "";
	cadena = "?md=" + $("#md").val() + "&modeCerca="
			+ $("select[id='selCerc']").val();
	cadena = cadena + "&titol=" + $("input[name='titol']").val();
	cadena = cadena + "&quan=" + $("select[id='selQuan']").val();
	cadena = cadena + "&anyPub=" + $("input[name='anyPub']").val();

	if (cadCerca == "") {
		iniCerca = "&ini=0";
	} else {
		iniCerca = "&ini=" + cadCerca;
	}
	cadena += iniCerca + getCadenaTipus("tipusPubli")
			+ getCadenaTipus("classifica");

	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("resultados").innerHTML = xmlhttp.responseText;
		}
	};

	xmlhttp.open("GET", "serveis/cerca.php" + cadena, true);
	xmlhttp.send();
}