<?php

   $path = $_GLOBAL['URL'];
// echo "<script type='text/javascript' src='js/main.js'></script>"; 
echo "<script type='text/javascript' src='$path/js/jquery.js'></script>";
echo "<script type='text/javascript' src='$path/js/jquerymd5.js'></script>";

echo "<script type='text/javascript'>
		if ($.browser.msie){
			document.write(\"<link rel='stylesheet' type='text/css' href='$path/css/main.css'/>\");
		}else{
			document.write(\"<link rel='stylesheet' type='text/css' href='$path/css/main.css'/>\");
		}
	</script> ";

?>
