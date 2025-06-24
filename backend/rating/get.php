<?php

include "../connect.php";

$itemid = filterRequest("itemid");

$stmt = $con->prepare("SELECT  rating.rating_id,rating.rating_stars,rating_comment,rating.rating_datetime, user_id, user.user_name, user.user_pfp 
FROM rating 
INNER JOIN user ON user.user_id = rating.rating_userid
WHERE rating.rating_itemid = '$itemid' ORDER BY rating.rating_stars DESC");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
