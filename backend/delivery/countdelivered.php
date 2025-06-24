<?php

include "../connect.php";

$workerid = filterRequest("id");

$stmt = $con->prepare("SELECT COUNT(order_id) AS count_total
FROM orders
JOIN delivery ON orders.order_id = delivery.delivery_orderid
WHERE orders.order_status >= 3 
AND delivery.delivery_workerid = '$workerid'");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
