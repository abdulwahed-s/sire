<?php

include "../connect.php";

$orderid = filterRequest("orderid");

$table ="orders";
$data = array("order_status" => "-1");


updateData($table,$data,"order_id = '$orderid' AND order_status = 0");