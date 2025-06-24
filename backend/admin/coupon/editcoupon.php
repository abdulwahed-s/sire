<?php

include "../../connect.php";

$id = filterRequest("id");
$code = filterRequest("code");
$count = filterRequest("count");
$discount = filterRequest("discount");
$expirydate = filterRequest("expirydate");

$data = array(
    "coupon_code" => $code,
    "coupon_count" => $count,
    "coupon_discount" => $discount,
    "coupon_expirydate" => $expirydate,
);

updateData("coupon", $data,"coupon_id = '$id'");
