<?php

include "../connect.php";

$userId = filterRequest("userId");
$itemId = filterRequest("itemId");

deleteData("favourites", " favourite_userid = $userId AND favourite_itemid = $itemId");
