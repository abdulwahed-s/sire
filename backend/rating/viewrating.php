<?php

include "../connect.php";

$userId = filterRequest('userId');

$stmt = $con->prepare("SELECT rating.*, itemsview.* 
FROM `rating` 
JOIN `itemsview` ON rating.rating_itemid = itemsview.item_id
WHERE rating.rating_userid = '$userId'");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
