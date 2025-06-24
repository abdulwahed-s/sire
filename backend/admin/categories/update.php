<?php

include "../../connect.php";

$id = filterRequest("id");
$category_name = filterRequest("nameen");
$category_name_ar = filterRequest("namear");
$category_name_es = filterRequest("namees");
$imgname = imageUpload("../../upload/categories", "files");

if ($imgname == 'empty') {
    $data = array(
        "category_name" => $category_name,
        "category_name_ar" => $category_name_ar,
        "category_name_es" => $category_name_es,

    );
} else {
    deleteFile("../../upload/categories", filterRequest("oldimg"));
    $data = array(
        "category_name" => $category_name,
        "category_name_ar" => $category_name_ar,
        "category_name_es" => $category_name_es,
        "category_img" => $imgname,
    );
}

updateData("categories", $data, "category_id = '$id'");
