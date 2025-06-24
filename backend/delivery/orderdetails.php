<?php
include "../connect.php";

$orderid = filterRequest("orderid");

$stmt = $con->prepare("SELECT items.* 
FROM items
JOIN cart ON cart.cart_itemid = items.item_id
WHERE cart.cart_orderid = '$orderid'");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}



?>
