<?php

include "../../connect.php";

$title  = filterRequest("title");
$body   = filterRequest("body");
$imgname = imageUpload("../../upload/notification", "files");

sendNotifications(
    0,
    $title,
    $body,
    "",
    "",
    "http://192.168.1.2/ecommerce/upload/notification/$imgname",
    "coupon", // $icon
    "default", // $sound
    "#FF0000", // $color
    "/home", // $route
    0, // $badge
    "high", // $priority
    true // $json
);
