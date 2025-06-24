<?php

include "../connect.php";

$userId = filterRequest("userId");
$itemId = filterRequest("itemId");

deleteData("cart", "cart_id = (SELECT cart_id FROM cart WHERE '$userId' = cart_userid AND $itemId = cart_itemid LIMIT 1)");
