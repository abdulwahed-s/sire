<?php

include "../../connect.php";

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

insertData("coupon", $data);
