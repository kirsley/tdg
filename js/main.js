function marcarCanvi( id ){
        $("#accept" + id).css('display','block');
}
function validaCategoria(){
    if (($('input[name="nomCateg"]').val() != "")){
        $('form[name="formCat"]').submit();
    }else{
        $('input[id="nomCateg2"]').css("backgroundColor","#FF9999");
    }
}

function categoryList() {
        if (window.XMLHttpRequest) {
                // code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
        } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        $("listCat2").innerHTML = xmlhttp.responseText;
                }
        };

        xmlhttp.open("GET", "services/manage_category.php?accio=listCat", true);
        xmlhttp.send();
}



function acceptChanges(id){
        $("#accept" + id).css('display','none');
            querylist="accio=modCat&cat_id="+id;
        $("#cat"+ id).find("input").each(function () {
                querylist = querylist + "&" + $(this).prop('name') + "=" + encodeURIComponent($(this).val());
                    });
        document.location='admin?' + querylist;
    }

function deleteCat(id){
        res = confirm("Eliminar categoria " + id + "?");
            if (res){
                    document.location='admin?accio=delCat&cat_id='+ id ;
                //se Procede con el Eliminado
            }
    }

function sobre(elem) {
        elem.style.backgroundImage = "url('img/fonsOps.png')";
	elem.style.background = '#fff7ac';
}

function fora(elem) {
        elem.style.backgroundImage = "";
	elem.style.background = '#f3d772';
}

function get_platos() {
        $.ajax({
                url:"services/manage_platos.php",
                data: {"accio":"listPlat"},
                method:"POST",
                success: function(data){
                        $('#platList').html(data);
                }
        });
}

function listCategories(){
	$.ajax({
		url:"services/manage_category.php",
});
}


