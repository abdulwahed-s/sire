<?php

include "../../connect.php";

$orderid = filterRequest('orderid');
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => -1
);

updateData($table, $data, "order_id = '$orderid' AND order_status = 0");


sendToNotification("Your Order Has Been Canceled", "Your order has been canceled. If you have any questions or need help, feel free to contact our support team. We're here to assist you.", "$userID", "", "",null,"cancel");
