<?php

include "../connect.php";

$userid = filterRequest("userid");
$itemid = filterRequest("itemid");

// $stmt = $con->prepare("SELECT EXISTS (
//     SELECT 1
//     FROM cart c
//     WHERE 
//         c.cart_userid = '$userid' AND
//         c.cart_itemid = '$itemid' AND
//         c.cart_orderid > 0 AND
//         NOT EXISTS (
//             SELECT 1 
//             FROM rating r 
//             WHERE 
//                 r.rating_userid = c.cart_userid AND
//                 r.rating_itemid = c.cart_itemid
//         )
// ) AS has_ordered_but_not_reviewed;");
$stmt = $con->prepare("SELECT EXISTS (
    SELECT 1
    FROM cart c 
    JOIN orders o ON c.cart_orderid = o.order_id
    WHERE 
        c.cart_userid = '$userid' AND
        c.cart_itemid = '$itemid' AND
        o.order_status IN (3,5,6)  AND
        NOT EXISTS (
            SELECT 1 
            FROM rating r 
            WHERE 
                r.rating_userid = c.cart_userid AND
                r.rating_itemid = c.cart_itemid
        )
) AS has_ordered_but_not_reviewed;");
$stmt->execute();
$data = $stmt->fetch(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($data['has_ordered_but_not_reviewed'] != 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "failure"));
}
