<?php

include "../connect.php";

$userid = filterRequest("userID");
$orderid = filterRequest("orderID");

getAllData("ordersview", "order_userid = '$userid'  AND cart_orderid = '$orderid'");
