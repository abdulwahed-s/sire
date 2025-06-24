<?php

include "../../connect.php";

$id = filterRequest("id");
$imgname = filterRequest("imgname");

deleteFile("../../upload/items", $imgname);
deleteData("items", "item_id = '$id'");