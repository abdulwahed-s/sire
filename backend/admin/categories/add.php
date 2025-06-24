<?php

include "../../connect.php";

$category_name = filterRequest("nameen");
$category_name_ar = filterRequest("namear");
$category_name_es = filterRequest("namees");
$imgname = imageUpload("../../upload/categories","files");

$data = array(
    "category_name" => $category_name,
    "category_name_ar" => $category_name_ar,
    "category_name_es" => $category_name_es,
    "category_img" => $imgname,

);

insertData("categories",$data);