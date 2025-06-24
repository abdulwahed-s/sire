<?php
include "../connect.php";

$orderid = filterRequest('orderid');
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => 3
);

updateData($table, $data, "order_id = '$orderid' AND order_status = 2");

sendToNotification("📦 Order Delivered!", "Your order has arrived! We hope you enjoy it. Let us know if everything was perfect!", $userID, '', '',null,"donedelivery");
