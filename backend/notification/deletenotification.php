<?php

include "../connect.php";

$userID = filterRequest("userID");
$notificationID = filterRequest("notificationID");

deleteData("notification", "notification_userid = '$userID' AND notification_id = '$notificationID'");
