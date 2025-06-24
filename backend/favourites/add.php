<?php

include "../connect.php";

$userId = filterRequest("userId");
$itemId = filterRequest("itemId");
$data = array(
    "favourite_userid" => $userId,
    "favourite_itemid" => $itemId
);
insertData("favourites", $data);
