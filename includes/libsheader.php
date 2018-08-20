<?php

   $path = $GLOBALS['URL'];
echo "<script type='text/javascript' src='js/main.js'></script>\n"; 
echo "<script type='text/javascript' src='$path/js/jquery.js'></script>\n";
echo "<script type='text/javascript' src='$path/js/jquerymd5.js'></script>\n";

echo "<script type='text/javascript'>
		if ($.browser.msie){
			document.write(\"<link rel='stylesheet' type='text/css' href='$path/css/admin-main.css'/>\");
		}else{
			document.write(\"<link rel='stylesheet' type='text/css' href='$path/css/admin-main.css'/>\");
		}
</script> \n";

?>
