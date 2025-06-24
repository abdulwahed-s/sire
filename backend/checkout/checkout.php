<?php

include "../connect.php";

$table = "orders";

$userid = filterRequest("userid");
$addressid = filterRequest("ordaddressiderid");
$type = filterRequest("type");
$price = filterRequest("price");
$paymenttype = filterRequest("paymenttype");
$coupon = filterRequest("coupon");

if ($type == 0) {
    $deliveryprice = filterRequest("deliveryprice");
} else {
    $deliveryprice = 0;
}

$now = date('Y-m-d H:i:s');
$couponcheck = returnData("coupon", "coupon_id = $coupon AND coupon_expirydate >= '$now' AND coupon_count > 0");
if ($couponcheck['status'] == 'success' && $couponcheck['data']) {
    $discount = $couponcheck['data']['coupon_discount'];
    $totalprice = ($price + $deliveryprice) + ($price * $discount / 100);
    $stmt = $con->prepare("UPDATE `coupon` SET `coupon_count`= `coupon_count` - 1 WHERE coupon_id = '$coupon'");
    $stmt->execute();
} else {
    $totalprice = $price + $deliveryprice;
}

$data = array(
    "order_userid" => $userid,
    "order_addressid" => $addressid,
    "order_type" => $type,
    "order_price" => $price,
    "order_pricedelivery" => $deliveryprice,
    "order_totalprice" => $totalprice,
    "order_paymenttype" => $paymenttype,
    "order_coupon" => $coupon,
);

$count  = insertData($table, $data, false);

if ($count > 0) {
    $stmt = $con->prepare("SELECT MAX(order_id) FROM orders");
    $stmt->execute();
    $maxid = $stmt->fetchColumn();
    $data = array("cart_orderid" => $maxid);
    updateData("cart", $data, "cart_userid = '$userid' AND cart_orderid = 0");
    sendNotifications(2, "New Order Placed", "A new order has been placed. Please review and begin processing the order as soon as possible.", "", "",null,"orderplaced");
}
