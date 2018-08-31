function setLanguage(idioma){
        $('input[name="language"]').val(idioma);
        $('form[name="langForm"]').submit();
}
function resetLanguages(){
        $('form[name="langReset"]').submit();
        
}
