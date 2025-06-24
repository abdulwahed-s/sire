<?php

include "../connect.php";

$coupon = filterRequest("coupon");

$now = date('Y-m-d H:i:s');

getAllData("coupon","coupon_code = '$coupon' AND coupon_expirydate >= '$now' AND coupon_count > 0");
