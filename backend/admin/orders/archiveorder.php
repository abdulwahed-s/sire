<?php

include "../../connect.php";

$orderid = filterRequest('orderid');
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => 6
);

updateData($table, $data, "order_id = '$orderid' AND order_status = 3 OR order_status = 5");


sendToNotification("Order Archived", "Your order has been archived and moved to your order history. You can view the details anytime from your account.", "$userID", "", "",null,"archive");
