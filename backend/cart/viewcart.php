<?php

include "../connect.php";

$userId = filterRequest("userId");

$data = getAllData("cartview", "cart_userid = '$userId'", null, false);

$stmt = $con->prepare("SELECT SUM(totalprice) AS carttotal, SUM(countitems) as itemstotal FROM `cartview` WHERE cart_userid = '$userId' GROUP BY cart_userid");
$stmt->execute();

$totalCountAndPrice = $stmt->fetch(PDO::FETCH_ASSOC);

if (!is_null($totalCountAndPrice) && !is_null($data)) {
    echo json_encode(array(
        "status" => "success",
        "datacart" => $data,
        "totalCountAndPrice" => $totalCountAndPrice
    ));
}else{
    echo json_encode(array("status" => "failure"));
}
