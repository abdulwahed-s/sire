<?php

include "../connect.php";

$userId = filterRequest("userId");
$itemId = filterRequest("itemId");

getCount("cart_id", "cart", "cart_userid = '$userId' AND cart_itemid = '$itemId'");
