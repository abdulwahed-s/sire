<?php

include "../../connect.php";

$orderid = filterRequest('orderid');
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => 5
);

updateData($table, $data, "order_id = '$orderid' AND order_status = 4 AND order_type = 1");


sendToNotification("Order Picked Up Successfully", "You've picked up your order. We hope you enjoy your purchase! Thank you for choosing us.", "$userID", "", "",null,"donepickup");

