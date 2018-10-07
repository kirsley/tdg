<?php
    include_once 'headers.php';
    $mainSrvDbh=conectarpdo($GLOBALS['MYSQL_BDNAME']);
    $result = "";
    if (isset($_POST['accio']) && $_POST['accio'] == 'listPlat'){
        if (isset($_POST['cat_id'])){
            $cat_id = $_POST['cat_id'];
        } else {
            $cat_id = 0;
        }
        if (isset($_POST['startP'])){
            $start = $_POST['startP'];
            $limit=6;
        }
        if (isset($_POST['lang'])){
            $lang=$_POST['lang'];
        }
        if ($cat_id > 0){

            $products=getProductsByCategory($mainSrvDbh,$cat_id,$lang,$start,$limit);
            $cnt=count($products);
    //        echo $cnt;
            $prodCnt=countProd($mainSrvDbh,$cat_id);

            if (($start + $limit) < $prodCnt){
                    $newStart = $start + $limit;
            } else {
                    $newStart = $start;
            }
            $newEnd = $start - $limit;
            $divId="platos";
            if ($cnt == 3 || $cnt >= 5) {
                    $divId="platos3";
            }
            $mxCol=3;
            if($cnt == 2 || $cnt == 4){
                    $mxCol=2;
            }
            $result .= "<div id='" . $divId ."' >";
            $result .= "<table>";
            $result .= "<tr>";
            $cont=0;
            for($i = 0; $i < $cnt; $i++){
                $prod=$products[$i];
                $result .= "<td class='platotd' ><a href='".$prod->cat_url . "/" . $prod->url ."'><img class='platoimg' src='" . $prod->img_path ."' /> </a></td>";
                $cont++;
                if ($cont % $mxCol ==0){
                    $result .= "</tr>";
                    $result .= "<tr>";
                    for ($a = $i - ($mxCol - 1); $a <= $i; $a++){
                        $result .= "<th align='justify'>" . $products[$a]->translation . "</th>";
                    }
                    $result .= "</tr>";
                    $result .= "<tr>";
                    $cont = 0;
    		    }
            }
            $result .= "</tr>";
            if($newEnd >= 0 || $newStart <> $start ){
                $result .= "<tr><td>";
                if($newEnd >= 0){
                    $result .= "<div class=\"botonLst fltLeft\"><img src=\"img/black-back.png\" id=\"myLink\" onclick=\"listaPlatos(".$newEnd."," . $cat_id .", '" . $lang . "')\" /></div>";
                }
                $result .= "</td>";

                if ($newStart <> $start) {
                    $result .= "<td></td>"; //Anado el del medio
                    $result .= "<td>";
                    //$result .= "<div id=\"myLink\" onclick=\"listaPlatos(".$newStart."," . $cat_id .", '" . $lang . "')\">Siguiente</div>";
                    $result .= "<div class=\"botonLst fltRight\"><img src=\"img/black-fwd.png\" id=\"myLink\" onclick=\"listaPlatos(".$newStart."," . $cat_id .", '" . $lang . "')\" /></div>";
                    $result .= "</td>";
                }
                $result .= "</tr>";
            }
            $result .= "</table>";
            $result .= "</div>";
        }        
        echo $result;
    } elseif (isset($_POST['accio']) && $_POST['accio'] == 'listCat') {
        $maxCatCnt=10;
        if (isset($_POST['lang'])){
            $lang=$_POST['lang'];
        }
        $catCnt=getUsedCategoryCnt($mainSrvDbh,$lang,1);

        if (isset($_POST['startP'])){
            $start = $_POST['startP'];
            $limit=$maxCatCnt;
        }

        if (($start + $limit) < $catCnt){
                $newStart = $start + $limit;
        } else {
                $newStart = $start;
        }
        $newEnd = $start - $limit;
        $categories= getCategoryLang($mainSrvDbh,$lang,1,$start,$limit);
        
        $result .= "<div id=\"menu\">";
        $result .= "<table >";
        //$result .= "<tr>";
        $cont=0;
        foreach ($categories as $cat){
            if ($cont % 2 == 0){
                $result .= "<tr>";
                $result .= "<td> <div class=\"opcMenu\" onclick=\"window.location.href='" . $cat->url . "'\"> <div class='inText' >" . $cat->descrip . "</div> </div></td>";
            } else {
                $result .= "<td> <div class=\"opcMenu\" onclick=\"window.location.href='" . $cat->url . "'\"> <div class='inText' >" . $cat->descrip . "</div> </div></td>";
                $result .= "</tr>";           
            }
            $cont = $cont + 1;
        }
        if ($cont % 2 == 1){
            $result .= "</tr>";
        }
        //$result .= "<tr><td> Start = " . $start . " <br /> Count = ".$catCnt . "</td><td>" . $newEnd . "</td></tr>";
        if($newEnd >= 0 || $newStart <> $start ){  

                $result .= "<tr><td style=\"background-color: transparent;border-color: transparent;\">";
                if($newEnd >= 0){
                    $result .= "<div class=\"botonLst fltLeft\"><img src=\"img/black-back.png\" id=\"myLink\" onclick=\"listaCategorias(".$newEnd.",'" . $lang . "')\" /></div>";
                }
                $result .= "</td>";

                if ($newStart <> $start) {
                    $result .= "<td style=\"background-color: transparent;border-color: transparent;\">";
                    $result .= "<div class=\"botonLst fltRight\"><img src=\"img/black-fwd.png\" id=\"myLink\" onclick=\"listaCategorias(".$newStart.",'" . $lang . "')\" /></div>";
                    $result .= "</td>";
                }
                $result .= "</tr>";

        }
        $result .= "              </table>";
        $result .= "          </div>";
        echo $result;
    }


    desconectarpdo($mainSrvDbh);
?>

