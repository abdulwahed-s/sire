<?php

include "../../connect.php";

$id = filterRequest("id");
$imgname = filterRequest("imgname");

deleteFile("../../upload/categories", $imgname);
deleteData("categories", "category_id = '$id'");