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
            echo $e->getMessage();
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
    
    /** ManaginG Data**/
    function getLanguages($dbh){
        $stmt= $dbh->prepare("SELECT * from language");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_CLASS, "language");
        return $result;
    }
    function getCategories($dbh){
        $stmt= $dbh->prepare("SELECT * from category");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_CLASS, "category");
        return $result;        
    }

    function getProdBasLstCat($dbh,$cat_id,$start = null,$limit = null){
        $products = [];
        $prod=getProductsByCategory($dbh,$cat_id,'esp',$start,$limit);
        if ($prod){
            foreach($prod as $p){

                $products[$p->id] = $p;
            }
        }
        return $products;
    }
    function getProductListsBasic($dbh,$start = null){
	$categories = getCategories($dbh);
	$products = [];
	foreach ($categories as $cat){
		$prod=getProductsByCategory($dbh,$cat->id,'esp',$start);
		if ($prod){
			foreach($prod as $p){
				
				$products[$p->id] = $p;
			}
		}
	}
	return $products;
    }

    function deletePlatos($dbh,$platos){
        $query="delete from prod_trans WHERE prod_id in(".implode(",", $platos).")";
        $stmt=$dbh->prepare($query);
        $success1=$stmt->execute();
        $query="DELETE from product WHERE id in (".implode(",", $platos).")";
        $stmt=$dbh->prepare($query);
        $success2=$stmt->execute();
        
        return $success1 && $success2;
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

    function insertPlate($dbh,$cat_id,$name,$url,$languages,$imgPath){
	$stmt = $dbh->prepare("INSERT INTO product (name,url,img_path,cat_id)  VALUES (:name,:url,:imgpath,:catid)");
	$stmt->bindParam(":url",$url);
	$stmt->bindParam(":name",$name);
        $stmt->bindParam(":imgpath",$imgPath);
        $stmt->bindParam(":catid",$cat_id);
	$stmt->execute();
	$plateId=$dbh->lastInsertId();
        if($plateId){
            if (count($languages) > 0){
                $stmt2=$dbh->prepare("INSERT INTO prod_trans (prod_id,lang_id,translation) values (:prodId,:langId,:languages)");
                $stmt2->bindParam(':prodId', $plateId);
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
	return $plateId;
    }

    function insertCategory($dbh,$url,$languages){
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
	return $catId;
    }

    function getCategoryListing($dbh){
    	$tmpcategory_list=getCategories($dbh);
    	$stmt = $dbh->prepare("SELECT * from cat_trans WHERE cat_id = :cid order by cat_id,lang_id");
    	$stmt->bindParam(":cid",$cid);
        $categoryList=[];
    	foreach ( $tmpcategory_list as $category ){
    		$cid=$category->id;
    		$stmt->execute();
    		$translations=[];
    		while($result = $stmt->fetch(PDO::FETCH_ASSOC)){
    			$translations[$result['lang_id']]=$result['translation'];
    		}
    		$myCategory=new fullCategory();
    		$myCategory->id = $category->id;
    		$myCategory->url = $category->url;
    		$myCategory->translations = $translations;
    		
    		$categoryList[$category->id]=$myCategory;
    	}
    	return $categoryList;
    }
    function getFullPlato($dbh,$plId){
	    $stmt=$dbh->prepare("SELECT * from product WHERE id = :pId");
	$stmt->bindValue(":pId",$plId);
	    $stmt->execute();
	    $result = $stmt->fetch(PDO::FETCH_ASSOC);
	    $myProduct= new fullProduct();
	    $myProduct->id = $result['id'];
            $myProduct->name = $result['name'];
            $myProduct->url = $result['url'];
            $myProduct->img_path = $result['img_path'];
            $myProduct->cat_id = $result['cat_id'];
	    $stmt2=$dbh->prepare("select l.id,l.lang,pt.translation from prod_trans pt,language l where pt.lang_id = l.id and pt.prod_id = :pId");
	    $stmt2->bindValue(":pId",$plId);
	    $stmt2->execute();
	    while($result1 = $stmt2->fetch(PDO::FETCH_ASSOC)){
                        $myProduct->translations[$result1['id']]=[$result1['lang'],$result1['translation']];
	     }
		    //print_r($myProduct->$translations);
	    return $myProduct;

    }

    function removeCategory($dbh,$cat){
	$success = 0;
        if(!getProductsByCategory($dbh,$cat)){
            $stmt = $dbh->prepare("DELETE from category WHERE id = :cat");
            $stmt->bindValue(":cat",$cat);
            $success=$stmt->execute();
            $stmt = $dbh->prepare("DELETE from cat_trans WHERE cat_id = :cat_id");
            $stmt->bindValue(":cat_id",$cat);
            $stmt->execute();
        }
	return $success;
    }

    function updateCategory($dbh,$catId,$languages){
        $stmt = $dbh->prepare("UPDATE cat_trans set translation = :trans WHERE cat_id = :cat_id AND lang_id = :lang_id");
    	$stmt->bindValue(":cat_id",$catId);
    	$stmt->bindParam(":trans",$trans);
	    $stmt->bindParam(":lang_id",$lang_id);
    	$langKeys=array_keys($languages);
	    foreach ($langKeys as $lang_id) {
            $trans = htmlChars($languages[$lang_id]);
            $stmt->execute();           
        }
    }

    function modificarPlato($dbh,$pId,$cat_id,$name,$url,$languages,$imgPath){
	    $stmt=$dbh->prepare("UPDATE product SET name= :name , url = :url,cat_id = :catId WHERE id=:pid");
	    $stmt->bindValue(":name",$name);
	    $stmt->bindValue(":url",$url);
	    $stmt->bindValue(":catId",$cat_id);
	    $stmt->bindValue(":pid",$pId);
	    $stmt->execute();
	    if($imgPath){
                $stmt2=$dbh->prepare("UPDATE product SET img_path = :imgPath WHERE id=:pid");
                $stmt2->bindValue(":pid",$pId);
		$stmt2->bindValue(":imgPath",$imgPath);
		$stmt2->execute();
	    }
	    $stmt3=$dbh->prepare("UPDATE prod_trans SET translation = :trans WHERE prod_id = :pid AND lang_id = :lang_id");
	    $stmt3->bindValue(":pid",$pId);
	    $stmt3->bindParam(":lang_id",$lang_id);
	    $stmt3->bindParam(":trans",$trans);
	    $langKeys=array_keys($languages);
            foreach ($langKeys as $lang_id) {
            	$trans = htmlChars($languages[$lang_id]);
	        $stmt3->execute();
        }
    }


    function getProductsByCategory($dbh,$cat,$lang='esp',$start = null,$limit = null){
	#$query="SELECT p.id,p.name,p.url,p.img_path,c.cat_id,c.translation from product p,cat_trans c,language l where  l.id = c.lang_id AND c.cat_id = p.cat_id AND l.langShort = '" . $lang . "'";
	$query="select p.id,p.name,p.url,p.img_path,p.cat_id,c.url as cat_url,pt.translation from product p, prod_trans pt,language l,category c where c.id = p.cat_id AND p.id = pt.prod_id AND pt.lang_id = l.id AND l.langShort = '". $lang ."'";
	if($cat > 0){
		$query .= " AND p.cat_id = :cat_id";
	}
    $query .= " ORDER by p.name,p.id";
	if(isset($start)){
		if ($limit){
			$query .= " LIMIT " . $start .",". $limit ;
		} else {
			$query .= " LIMIT " . $start .",12" ;
		}
	}
    //echo $query;
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(":cat_id",$cat);
	$stmt->execute();
        $product_list = $stmt->fetchAll(PDO::FETCH_CLASS, "product");
        return $product_list;
    }

    function countProd($dbh,$cat_id){
        $query = "SELECT count(*) as cnt from  product";
        if ($cat_id){
            $query .= " WHERE cat_id = " . $cat_id;
       }
        $stmt = $dbh->prepare($query);
        $stmt->execute();
        $cnt = $stmt->fetch(PDO::FETCH_ASSOC);
        return $cnt['cnt'];

    }

    function uploadImage($cat_id,$url){
        $idImg=0;
	$destFolder='uploads';
        if(is_uploaded_file($_FILES['pltImg']['tmp_name'])) {
		$name=generateUrl($_FILES['pltImg']['name']);
		
		$ext=array_values(array_slice(explode(".",$name), -1))[0];
		$name=$url . "-" . $cat_id . "." . $ext;
		$tmp_name = $_FILES['pltImg']['tmp_name'];
		$destPath=$destFolder . "/" . $name;
		move_uploaded_file($tmp_name, $destPath);
		$idImg=$destPath;
        }
        return $idImg;
    }



    function htmlChars($str){
	$str=str_replace("&","&amp;",$str);
	$str=str_replace("'","&#39;",$str);
	$charEq = array('Á','á','À','Â','à','Â','â','Ä','ä','Ã','ã','Å','å','Æ','æ','Ç','ç','Ð','ð','É','é','È','è','Ê','ê','Ë','ë','Í','í','Ì','ì','Î','î','Ï','ï','Ñ','ñ','Ó','ó','Ò','ò','Ô','ô','Ö','ö','Õ','õ','Ø','ø','ß','Þ','þ','Ú','ú','Ù','ù','Û','û','Ü','ü','Ý','ý','ÿ');
        $htmlChars = array('&Aacute;','&aacute;','&Agrave;','&Acirc;','&agrave;','&Acirc;','&acirc;','&Auml;','&auml;','&Atilde;','&atilde;','&Aring;','&aring;','&Aelig;','&aelig;','&Ccedil;','&ccedil;','&Eth;','&eth;','&Eacute;','&eacute;','&Egrave;','&egrave;','&Ecirc;','&ecirc;','&Euml;','&euml;','&Iacute;','&iacute;','&Igrave;','&igrave;','&Icirc;','&icirc;','&Iuml;','&iuml;','&Ntilde;','&ntilde;','&Oacute;','&oacute;','&Ograve;','&ograve;','&Ocirc;','&ocirc;','&Ouml;','&ouml;','&Otilde;','&otilde;','&Oslash;','&oslash;','&szlig;','&Thorn;','&thorn;','&Uacute;','&uacute;','&Ugrave;','&ugrave;','&Ucirc;','&ucirc;','&Uuml;','&uuml;','&Yacute;','&yacute;','&yuml;');
	return str_replace($charEq, $htmlChars, $str);
    }	

    function generateUrl($str) {
	$str=strtolower($str);
        $str=str_replace("'","-",$str);
        $str=str_replace(" ","-",$str); 
	$str=str_replace("&","-",$str);
        $str=str_replace("---","-",$str);  
        $str=str_replace("--","-",$str);  
    
        $a = array('À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'ß', 'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'ÿ', 'Ā', 'ā', 'Ă', 'ă', 'Ą', 'ą', 'Ć', 'ć', 'Ĉ', 'ĉ', 'Ċ', 'ċ', 'Č', 'č', 'Ď', 'ď', 'Đ', 'đ', 'Ē', 'ē', 'Ĕ', 'ĕ', 'Ė', 'ė', 'Ę', 'ę', 'Ě', 'ě', 'Ĝ', 'ĝ', 'Ğ', 'ğ', 'Ġ', 'ġ', 'Ģ', 'ģ', 'Ĥ', 'ĥ', 'Ħ', 'ħ', 'Ĩ', 'ĩ', 'Ī', 'ī', 'Ĭ', 'ĭ', 'Į', 'į', 'İ', 'ı', 'Ĳ', 'ĳ', 'Ĵ', 'ĵ', 'Ķ', 'ķ', 'Ĺ', 'ĺ', 'Ļ', 'ļ', 'Ľ', 'ľ', 'Ŀ', 'ŀ', 'Ł', 'ł', 'Ń', 'ń', 'Ņ', 'ņ', 'Ň', 'ň', 'ŉ', 'Ō', 'ō', 'Ŏ', 'ŏ', 'Ő', 'ő', 'Œ', 'œ', 'Ŕ', 'ŕ', 'Ŗ', 'ŗ', 'Ř', 'ř', 'Ś', 'ś', 'Ŝ', 'ŝ', 'Ş', 'ş', 'Š', 'š', 'Ţ', 'ţ', 'Ť', 'ť', 'Ŧ', 'ŧ', 'Ũ', 'ũ', 'Ū', 'ū', 'Ŭ', 'ŭ', 'Ů', 'ů', 'Ű', 'ű', 'Ų', 'ų', 'Ŵ', 'ŵ', 'Ŷ', 'ŷ', 'Ÿ', 'Ź', 'ź', 'Ż', 'ż', 'Ž', 'ž', 'ſ', 'ƒ', 'Ơ', 'ơ', 'Ư', 'ư', 'Ǎ', 'ǎ', 'Ǐ', 'ǐ', 'Ǒ', 'ǒ', 'Ǔ', 'ǔ', 'Ǖ', 'ǖ', 'Ǘ', 'ǘ', 'Ǚ', 'ǚ', 'Ǜ', 'ǜ', 'Ǻ', 'ǻ', 'Ǽ', 'ǽ', 'Ǿ', 'ǿ', 'Ά', 'ά', 'Έ', 'έ', 'Ό', 'ό', 'Ώ', 'ώ', 'Ί', 'ί', 'ϊ', 'ΐ', 'Ύ', 'ύ', 'ϋ', 'ΰ', 'Ή', 'ή');
        $b = array('A', 'A', 'A', 'A', 'A', 'A', 'AE', 'C', 'E', 'E', 'E', 'E', 'I', 'I', 'I', 'I', 'D', 'N', 'O', 'O', 'O', 'O', 'O', 'O', 'U', 'U', 'U', 'U', 'Y', 's', 'a', 'a', 'a', 'a', 'a', 'a', 'ae', 'c', 'e', 'e', 'e', 'e', 'i', 'i', 'i', 'i', 'n', 'o', 'o', 'o', 'o', 'o', 'o', 'u', 'u', 'u', 'u', 'y', 'y', 'A', 'a', 'A', 'a', 'A', 'a', 'C', 'c', 'C', 'c', 'C', 'c', 'C', 'c', 'D', 'd', 'D', 'd', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'G', 'g', 'G', 'g', 'G', 'g', 'G', 'g', 'H', 'h', 'H', 'h', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'IJ', 'ij', 'J', 'j', 'K', 'k', 'L', 'l', 'L', 'l', 'L', 'l', 'L', 'l', 'l', 'l', 'N', 'n', 'N', 'n', 'N', 'n', 'n', 'O', 'o', 'O', 'o', 'O', 'o', 'OE', 'oe', 'R', 'r', 'R', 'r', 'R', 'r', 'S', 's', 'S', 's', 'S', 's', 'S', 's', 'T', 't', 'T', 't', 'T', 't', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'W', 'w', 'Y', 'y', 'Y', 'Z', 'z', 'Z', 'z', 'Z', 'z', 's', 'f', 'O', 'o', 'U', 'u', 'A', 'a', 'I', 'i', 'O', 'o', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'A', 'a', 'AE', 'ae', 'O', 'o', 'Α', 'α', 'Ε', 'ε', 'Ο', 'ο', 'Ω', 'ω', 'Ι', 'ι', 'ι', 'ι', 'Υ', 'υ', 'υ', 'υ', 'Η', 'η');
    
        return str_replace($a, $b, $str);
    }
    
    
    /***** FUNCTIONS for INDEX ****/
    function getCategoryLang($dbh,$lang,$filtered){
	$query = "SELECT c.id as cat_id,c.url as url, ct.translation as translation from category c, cat_trans ct where c.id = ct.cat_id AND ct.lang_id = (select id from language where langShort = :lang)";
	if($filtered){
		$query .= " AND c.id in (select cat_id from product)";
	}
        $stmt=$dbh->prepare($query);
        $stmt->bindValue(":lang",$lang);
        $result=$stmt->execute();
        $categories=[];
        while($result = $stmt->fetch(PDO::FETCH_ASSOC)){
            $newCat=new langCategory();
            $newCat->id = $result['cat_id'];
            $newCat->url = $result['url'];
            $newCat->descrip = $result['translation'];
            $categories[$newCat->id]=$newCat;
        }
        return $categories;
    }
?>
