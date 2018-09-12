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

class product {
    public $id;
    public $name;
    public $url;
    public $img_path;
    public $cat_id;
    public $cat_url;
    public $translation;
}

class fullProduct {
    public $id;
    public $name;
    public $url;
    public $img_path;
    public $cat_id;
    public $translations=[];
}
?>
