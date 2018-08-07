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
    
    
?>
