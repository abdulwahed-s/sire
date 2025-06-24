<?php

include "../connect.php";

$orderid = filterRequest('orderid');
$workerid = filterRequest("workerid");
$userID = filterRequest("userid");

$table = "orders";

$data = array(
    "order_status" => 2
);

updateData($table, $data, "order_id = '$orderid' AND order_status = 1.5");

$deliverydata = array(
    "delivery_workerid" => $workerid,
    "delivery_orderid" => $orderid
);

insertData("delivery", $deliverydata, false);

$stmt = $con->prepare("SELECT user_id FROM user WHERE user_keyaccess = '1' AND user_id != $workerid");
$stmt->execute();
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($users as $row) {
    $user_id = $row['user_id'];
    sendToNotification(
        "📦 Order #$orderid Accepted",
        "The order has been accepted by delivery partner ID: $workerid.",
        $user_id,
        "",
        "",
        null,
        "accepteddelivery"
    );
}

sendToNotification("Your Order is On the Way!", "The delivery partner has picked up your order and is on the way to you. Get ready—your items will arrive soon!", $userID, '', '', null, "delivery");
