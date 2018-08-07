<?php
//specific functions
/**
 * Función para establecer la conexión con la base de datos
 * @param String $db nombre de la base de datos
 * @return $link enlace de conexion con base de datos
 */

    function conectarpdo($db){
        $ip=$GLOBALS['MYSQL_IP'];
        $dsn = "mysql:host=".$ip.";dbname=".$db;
        $user=$GLOBALS['MYSQL_USER'];
        $pass=$GLOBALS['MYSQL_PASSWORD'];
        try{
        $dbh = new PDO($dsn,$user,$pass);
        } catch(PDOException $e){
            echo $e-getMessage();
        }
        
        return $dbh;
    }
    function desconectarpdo($dbh){
        $dbh = null;
    }
    
    /**
     * Funcion para buscar un usuario en la BD
     * @param String $user nombre de usuario
     * @return String $id de usuario si se encontro
     * 		   null si no se encontro usuario
     */
    function buscaUser($user , $dbh){
        $stmt=$dbh->prepare("SELECT * FROM users WHERE username=:user");
        $stmt->bindValue(":user",$user);
        $stmt->execute();
        
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $id=-999;
        if ($stmt->rowCount() == 1){
            $id=$result;
        }
        return $id;
    }
    
    /**
     * Funcion para validar si datos del usuario son correctos
     *  validando mediante busqueda de su $id y comprobando si $passwordlogin
     *  es identico al PASSWORD almacenado en la base de datos
     * @param String $user nombre de usuario
     * @param String $passwordLogin password login md5 del usuario
     * @return String $id de usuario si el usuario es valido
     * 		   null si el usuario no es valido
     */
    function verificaUserpdo($user , $passwordLogin , $dbh){
        $result=buscaUser($user,$dbh);
        $id = $result['id'];
        $password = $result['user_pass'];
        if ($password == $passwordLogin ){
            return $id;
        }else{
            return "";
        }
    }
    
    function esAdmin($user,$dbh){
        $fuser = buscaUser($user,$dbh);
        if (is_array($fuser)){
            $admin = $fuser['isAdmin'] == 1;
        } else {
            $admin = null;
        }
        return $admin;
    }
    
    class language{
        public $id;
        public $lang;
        public $langShort;
    }
    /** ManaginG Data**/
    function getLanguages($dbh){
        $stmt= $dbh->prepare("SELECT * from language");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_CLASS, "language");
        return $result;
    }
    class category {
        public $id;
        public $url;
    }
    function getCategories($dbh){
        $stmt= $dbh->prepare("SELECT * from category");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_CLASS, "category");
        return $result;        
    }
    function categoryExist($dbh,$url){
        $categories = getCategories($dbh);
        $exist="";
        foreach ($categories as $cat){
            if ($cat->url == $url){
                $exist = 1;
            }
        }
        return $exist;
    }
    function getCategory($dbh,$url){
        $stmt=$dbh->prepare("SELECT * FROM category WHERE url=:url");
        $stmt->bindValue(":url",$url);
        $stmt->execute();
        
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $id = -1;
        if ($stmt->rowCount() == 1){
            $id=$result['id'];
        }
        return $id;
        
    }
    
    function insertCategory($dbh,$url,$nomCategory,$languages){
        $stmt=$dbh->prepare("INSERT INTO category (url) values (:url)");
        $stmt->bindValue(":url",$url);
        $stmt->execute();
        $catId=getCategory($dbh,$url);
        if($catId < 0){
            echo "algo fallo";
        } else {
            if (count($languages) > 0){
                $stmt2=$dbh->prepare("INSERT INTO cat_trans (cat_id,lang_id,translation) values (:catId,:langId,:languages)");
                $stmt2->bindParam(':catId', $catId);
                $stmt2->bindParam(':langId', $lang_id);
                $stmt2->bindParam(':languages', $translation);
                $langKeys=array_keys($languages);
                foreach ( $langKeys as $key){
                    $lang_id=$key;
                    $translation=$languages[$key];
                    $stmt2->execute();
                }
            }
        }
    }
    function generateUrl($str) {        
        $str=str_replace(" ","-",$str);
        $a = array('À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'ß', 'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'ÿ', 'Ā', 'ā', 'Ă', 'ă', 'Ą', 'ą', 'Ć', 'ć', 'Ĉ', 'ĉ', 'Ċ', 'ċ', 'Č', 'č', 'Ď', 'ď', 'Đ', 'đ', 'Ē', 'ē', 'Ĕ', 'ĕ', 'Ė', 'ė', 'Ę', 'ę', 'Ě', 'ě', 'Ĝ', 'ĝ', 'Ğ', 'ğ', 'Ġ', 'ġ', 'Ģ', 'ģ', 'Ĥ', 'ĥ', 'Ħ', 'ħ', 'Ĩ', 'ĩ', 'Ī', 'ī', 'Ĭ', 'ĭ', 'Į', 'į', 'İ', 'ı', 'Ĳ', 'ĳ', 'Ĵ', 'ĵ', 'Ķ', 'ķ', 'Ĺ', 'ĺ', 'Ļ', 'ļ', 'Ľ', 'ľ', 'Ŀ', 'ŀ', 'Ł', 'ł', 'Ń', 'ń', 'Ņ', 'ņ', 'Ň', 'ň', 'ŉ', 'Ō', 'ō', 'Ŏ', 'ŏ', 'Ő', 'ő', 'Œ', 'œ', 'Ŕ', 'ŕ', 'Ŗ', 'ŗ', 'Ř', 'ř', 'Ś', 'ś', 'Ŝ', 'ŝ', 'Ş', 'ş', 'Š', 'š', 'Ţ', 'ţ', 'Ť', 'ť', 'Ŧ', 'ŧ', 'Ũ', 'ũ', 'Ū', 'ū', 'Ŭ', 'ŭ', 'Ů', 'ů', 'Ű', 'ű', 'Ų', 'ų', 'Ŵ', 'ŵ', 'Ŷ', 'ŷ', 'Ÿ', 'Ź', 'ź', 'Ż', 'ż', 'Ž', 'ž', 'ſ', 'ƒ', 'Ơ', 'ơ', 'Ư', 'ư', 'Ǎ', 'ǎ', 'Ǐ', 'ǐ', 'Ǒ', 'ǒ', 'Ǔ', 'ǔ', 'Ǖ', 'ǖ', 'Ǘ', 'ǘ', 'Ǚ', 'ǚ', 'Ǜ', 'ǜ', 'Ǻ', 'ǻ', 'Ǽ', 'ǽ', 'Ǿ', 'ǿ', 'Ά', 'ά', 'Έ', 'έ', 'Ό', 'ό', 'Ώ', 'ώ', 'Ί', 'ί', 'ϊ', 'ΐ', 'Ύ', 'ύ', 'ϋ', 'ΰ', 'Ή', 'ή');
        $b = array('A', 'A', 'A', 'A', 'A', 'A', 'AE', 'C', 'E', 'E', 'E', 'E', 'I', 'I', 'I', 'I', 'D', 'N', 'O', 'O', 'O', 'O', 'O', 'O', 'U', 'U', 'U', 'U', 'Y', 's', 'a', 'a', 'a', 'a', 'a', 'a', 'ae', 'c', 'e', 'e', 'e', 'e', 'i', 'i', 'i', 'i', 'n', 'o', 'o', 'o', 'o', 'o', 'o', 'u', 'u', 'u', 'u', 'y', 'y', 'A', 'a', 'A', 'a', 'A', 'a', 'C', 'c', 'C', 'c', 'C', 'c', 'C', 'c', 'D', 'd', 'D', 'd', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'G', 'g', 'G', 'g', 'G', 'g', 'G', 'g', 'H', 'h', 'H', 'h', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'IJ', 'ij', 'J', 'j', 'K', 'k', 'L', 'l', 'L', 'l', 'L', 'l', 'L', 'l', 'l', 'l', 'N', 'n', 'N', 'n', 'N', 'n', 'n', 'O', 'o', 'O', 'o', 'O', 'o', 'OE', 'oe', 'R', 'r', 'R', 'r', 'R', 'r', 'S', 's', 'S', 's', 'S', 's', 'S', 's', 'T', 't', 'T', 't', 'T', 't', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'W', 'w', 'Y', 'y', 'Y', 'Z', 'z', 'Z', 'z', 'Z', 'z', 's', 'f', 'O', 'o', 'U', 'u', 'A', 'a', 'I', 'i', 'O', 'o', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'A', 'a', 'AE', 'ae', 'O', 'o', 'Α', 'α', 'Ε', 'ε', 'Ο', 'ο', 'Ω', 'ω', 'Ι', 'ι', 'ι', 'ι', 'Υ', 'υ', 'υ', 'υ', 'Η', 'η');
    
        return str_replace($a, $b, $str);
    }
    
?>
