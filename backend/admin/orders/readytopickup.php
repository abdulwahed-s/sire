<?php

include "../../connect.php";


$orderid = filterRequest('orderid');
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => 4
);

updateData($table, $data, "order_id = '$orderid' AND order_status = 1 AND order_type = 1");


sendToNotification("Your Order is Ready for Pickup", "Your order is prepared and ready for pickup at the selected location. Thank you for shopping with us!", "$userID", "", "",null,"pickup");

