<?php
include "../../connect.php";

$stmt = $con->prepare("SELECT 
	orders.order_id,
    orders.order_type,
    orders.order_price,
    orders.order_pricedelivery,
    orders.order_totalprice,
    orders.order_paymenttype,
    orders.order_status,
    orders.order_datetime,
    coupon.coupon_code,
    coupon.coupon_discount, 
    user.user_id,
    user.user_name,
    user.user_email,
    user.user_phone,
    user.user_pfp,
    address.*
FROM `orders`
JOIN `user` ON orders.order_userid = user.user_id
LEFT JOIN `address` ON address.address_id = orders.order_addressid AND  orders.order_addressid != 0
LEFT JOIN `coupon` ON coupon.coupon_id = orders.order_coupon AND orders.order_coupon != 0");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
  echo json_encode(array("status" => "success", "data" => $data));
} else {
  echo json_encode(array("status" => "failure"));
}



/*    switch (statusCode) {
      case 0:
        return 'Pending Approval';
      case 1:
        return 'Preparing';
      case -1:
        return 'Cancelled';     
      case 5:
        return 'User Picked Up';
      case 6:
        return 'Archived';
    }

    if (orderType == 0) {
      switch (statusCode) {
        case 2:
          return 'On The Way';
        case 3:
          return 'Delivered';
      }
    } else {
      if (statusCode == 4) return 'Ready for Pickup';
    }  */