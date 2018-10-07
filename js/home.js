function setLanguage(idioma){
        $('input[name="language"]').val(idioma);
        $('form[name="langForm"]').submit();
}
function resetLanguages(){
        $('form[name="langReset"]').submit();
        
}


function listaPlatos(start,cat_id,lang){
	data = {"accio":"listPlat","startP":start,"cat_id":cat_id, "lang":lang};
        $.ajax({
                url:"services/manage_platelist.php",
                data: data,
                method:"POST",
                success: function(data){
                        $('#listaPlatosMain').html(data);
                }
        });
}


function listaCategorias(start,lang){
        data = {"accio":"listCat","startP":start, "lang":lang};
        $.ajax({
                url:"services/manage_platelist.php",
                data: data,
                method:"POST",
                success: function(data){
                        $('#opciones').html(data);
                }
        });
}