<?php

	echo "<div class='botones'>";
 	echo " <div class='boton' id='back' >";
    echo " <a href='../". $category ."' ><img src='../img/back.png' /></a>";
    echo " </div>";
	echo "<div class='boton' id='lista'>";
	echo "<a href='../index'> <img src='../img/lista.png' /> </a>";
	echo "</div>";
    echo "<div class=\"boton\" id=\"home\"  >";
    echo "<form action=\"../index\" method=\"post\" name=\"langReset\">";
    echo '<input type="hidden" name="lreset" value="reset">';
    echo "</form>";
    echo "<img src='../img/home.png' onclick='resetLanguages()' /> ";
    echo "</div>";

	echo "</div>";
?>