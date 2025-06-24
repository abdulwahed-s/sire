<?php

include "../connect.php";

$userid = filterRequest("userid");
$notificationid = filterRequest("notificationid");

$data = array(
    "is_read" => "1",
);

updateData("notification", $data, "notification_userid = '$userid'");
