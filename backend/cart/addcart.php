<?php

include "../connect.php";

$userId = filterRequest("userId");
$itemId = filterRequest("itemId");

$data = array(
    "cart_userid" => $userId,
    "cart_itemid" => $itemId
);

insertData("cart",$data);
