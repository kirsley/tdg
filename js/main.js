function marcarCanvi( id ){
        $("#accept" + id).css('display','block');
}
function validaCategoria(){
    if (($('input[name="nomCateg"]').val() != "")){
	console.log("Valida");
	insertCategory();
	
    }else{
        $('input[id="nomCateg2"]').css("backgroundColor","#FF9999");
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

function filterCategory(){
	var cat_id = $('#selectCat').val();
	listaPlatos(0,cat_id);
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

function listaPlatos(start,cat_id){
	data = {"accio":"listPlat","startP":start,"cat_id":cat_id};
        $.ajax({
                url:"services/manage_platos.php",
                data: data,
                method:"POST",
                success: function(data){
                        $('#platList').html(data);
                }
        });

}
function listCategories(){
	$.ajax({
		url:"services/manage_category.php",
		method: "GET",
		data: {"accio":"listCat"},
		success: function (data) {
			$('#listCat').html(data);
		}
	});
}

function insertCategory(){
	var data = $('form[name="formCat"]').serialize();
        $.ajax({
                url:"services/manage_category.php",
                method: "POST",
                data: data,
                success: function (data) {
                        listCategories();
                }
        });
}

function deleteCat(id){
	if ($("#accept" + id).css("display") == 'block' ) {
		//Cancela Modificación
		listCategories();
	} else {
		//Elimina la Categoria
		res = confirm("Eliminar categoria " + id + "?");
		if (res){
	        	$.ajax({
	        	        url:"services/manage_category.php",
	                	method: "POST",
		                data: {"accio":"delCat","cat_id":id  },
	        	        success: function (data) {
	                	        listCategories();
	                	}
		        });
	        }
	}
}
function acceptChanges(id){
        $("#accept" + id).css('display','none');
        var querylist="accio=modCat&cat_id="+id;
        $("#cat"+ id).find("input").each(function () {
        querylist = querylist + "&" + $(this).prop('name') + "=" + encodeURIComponent($(this).val());
                    });
	modifyCategory(querylist);
 }


function modifyCategory(data){
        $.ajax({
                url:"services/manage_category.php",
                method: "POST",
                data: data,
                success: function (data) {
                        listCategories();
                }
        });
}

