<?php

include "../connect.php";

$userid = filterRequest("id");

$stmt = $con->prepare("SELECT COUNT(order_id) AS 'orders_count' FROM `orders` WHERE order_userid = '$userid'");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
