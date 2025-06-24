<?php

include "../../connect.php";

$orderid = filterRequest('orderid');
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => 1
);

updateData($table, $data, "order_id = '$orderid'");


sendToNotification("Your Order is Being Prepared!", "We've accepted your order and it's now being prepared with care. We'll notify you once it's ready for dispatch. Thank you for shopping with us!", "$userID", "", "",null,"approve");

