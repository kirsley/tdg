<?php

class category {
    public $id;
    public $url;
}

class langCategory{
    public $id;
    public $url;
    public $descrip;
}
class fullCategory{
    public $id;
    public $url;
    public $translations=[];
}

class language{
    public $id;
    public $lang;
    public $langShort;
}

/*id INT AUTO_INCREMENT,
name VARCHAR(150),
url VARCHAR(150),
img_path VARCHAR(150),
cat_id INT,*/
class product {
    public $id;
    public $name;
    public $url;
    public $img_path;
    public $cat_id;
}
    
?>