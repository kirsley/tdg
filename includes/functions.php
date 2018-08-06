<?php
//specific functions
/**
 * Funci�n para establecer la conexi�n con la base de datos
 * @param String $db nombre de la base de datos
 * @return $link enlace de conexion con base de datos
 */
    function conectar($db){
        
        $ip=$GLOBALS['MYSQL_IP'];
        $user=$GLOBALS['MYSQL_USER'];
        $pass=$GLOBALS['MYSQL_PASSWORD'];
        $link=mysqli_connect($ip,$user,$pass,$db);
        if (mysqli_connect_errno())  {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
            echo "Error al intentar conectar a mysql";
        }
        return $link;
    }
    /**
     * Funci�n para terminar correctamente la conexi�n con la base de datos
     */
    function desconectar($link){        
        mysqli_close($link);
    }
    
?>