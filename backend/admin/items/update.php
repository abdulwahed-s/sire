<?php

include "../../connect.php";


$id = filterRequest("id");
$name = filterRequest("name");
$name_ar = filterRequest("namear");
$name_es = filterRequest("namees");
$description = filterRequest("desc");
$description_ar = filterRequest("descar");
$description_es = filterRequest("desces");
$count = filterRequest("count");
$active = filterRequest("active");
$price = filterRequest("price");
$discount = filterRequest("discount");
$catgoryid = filterRequest("catid");
$imgname = imageUpload("../../upload/items", "files");

if ($imgname == 'empty') {
    $data = array(
        "item_name" => $name,
        "item_name_ar" => $name_ar,
        "item_name_es" => $name_es,
        "item_desc" => $description,
        "item_desc_ar" => $description_ar,
        "item_desc_es" => $description_es,
        "item_count" => $count,
        "item_active" => $active,
        "item_price" => $price,
        "item_discount" => $discount,
        "item_cat" => $catgoryid
    );
} else {
    deleteFile("../../upload/items", filterRequest("oldimg"));
    $data = array(
        "item_name" => $name,
        "item_name_ar" => $name_ar,
        "item_name_es" => $name_es,
        "item_desc" => $description,
        "item_desc_ar" => $description_ar,
        "item_desc_es" => $description_es,
        "item_img" => $imgname,
        "item_count" => $count,
        "item_active" => $active,
        "item_price" => $price,
        "item_discount" => $discount,
        "item_cat" => $catgoryid
    );
}




updateData("items", $data, "item_id = '$id'");
