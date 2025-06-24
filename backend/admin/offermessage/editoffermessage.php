<?php

include "../../connect.php";


$title = filterRequest("title");
$body = filterRequest("body");
$imgname = imageUpload("../../upload/home", "files");

if ($imgname == 'empty') {
    $data = array(
        "mainpage_title" => $title,
        "mainpage_body" => $body,
    );
} else {
    deleteFile("../../upload/home", filterRequest("oldimg"));
    $data = array(
        "mainpage_title" => $title,
        "mainpage_body" => $body,
        "mainpage_image" => $imgname,
    );
}




updateData("mainpage", $data, "mainpage_id = '1'");
