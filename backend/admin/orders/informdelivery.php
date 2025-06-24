<?php

include "../../connect.php";

$orderid = filterRequest('orderid');
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => 1.5
);

updateData($table, $data, "order_id = '$orderid' AND order_status = 1 AND order_type = 0");

sendNotifications(1,"New Delivery Available", "An order is ready for delivery! Tap to view details and accept the delivery. Let’s get it to the customer on time.", "delivery", "", "",null,"awaitingdelivery");
