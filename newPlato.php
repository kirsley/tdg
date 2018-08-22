<?php
    echo "<h2>A&ntilde;adir Plato Nuevo</h2>";
    echo " <form enctype='multipart/form-data' method='POST' name='platForm' action='platos'>";
    echo " <input type='hidden' name='accio' value='newPlate' />";
    echo "<table>";
    echo "<tr><th class='frmTitle' >Nombre corto </th><td class='inputList'><input type='text' name='pltName' maxlength='40' value='' /> </td></tr>";
    echo "<tr><th class='frmTitle'>Imagen</th> <td class='inputList'><input name='pltImg' type='file' /></td></tr>";
    echo "<tr><th class='frmTitle'>Categoria </th>";
    echo " <td class='inputList'>";
    echo "<select name='pltCateg'>";
    $categories= getCategoryLang($adminLink,"esp");
    foreach ($categories as $cat){
        echo "<option value='".$cat->id."' >" . $cat->descrip ."</option>";
    }
    echo "</select>";
    echo " </td><tr>";
    echo "<tr><th colspan=2>Descricpi&oacute;n Por Idioma</th></tr>";
    $cont=0;
    $result=getLanguages($adminLink);
    foreach ($result as $elem){
        echo "<tr>";
        echo "<td class='frmTitle'>". $elem->lang . "</td>";
        echo "<td> <input name=\"lang" . $elem->id . "\" type=\"text\" value= \"\" /></td>";
    echo "</tr>";
    $cont++;
    }
    echo "<input type='hidden' name='totalLang' value='".$cont."' />";
    echo "<tr> <td></td><td class='inputList'><input class='boto' type='button' value='Agregar Producto' onClick='guardarNuevo()'></td>";
    echo " </tr>";
    echo "</table>";
    echo " </form>";
?>
