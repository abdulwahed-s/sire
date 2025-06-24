<?php

include "../connect.php";

$workerid = filterRequest("workerid");

$stmt = $con->prepare("SELECT 
    orders.order_totalprice,
    orders.order_datetime,
    orders.order_paymenttype,
    orders.order_id,
    orders.order_userid, 
    user.user_name,
    user.user_phone, 
    address.address_name,
    address.address_building,
    address.address_apt,
    address.address_floor,
    address.address_street,
    address.address_block,
    address.address_way,
    address.address_additional,
    address.address_bymap,
    address.address_deliverytime,
    address.address_marker,
    address.address_lat,
    address.address_long
FROM `orders`
JOIN `user` ON orders.order_userid = user.user_id
JOIN `address` ON address.address_id = orders.order_addressid
JOIN `delivery` ON delivery.delivery_orderid = orders.order_id
WHERE orders.order_status = 2
AND delivery.delivery_workerid = '$workerid'");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
