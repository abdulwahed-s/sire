<?php

include "../connect.php";

$alldata = array();

$alldata['status'] = "success";

$stmt = $con->prepare("SELECT SUM(orders.order_totalprice) AS totalSelling FROM orders");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["sales"]  = $data[0]['totalSelling'];
}

$stmt = $con->prepare("SELECT count(orders.order_id) AS ordersCount FROM orders");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["order"]  = $data[0]['ordersCount'];
}

$stmt = $con->prepare("SELECT count(items.item_id) AS itemsCount FROM items");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["items"]  = $data[0]['itemsCount'];
}

$stmt = $con->prepare("SELECT COUNT(user_id) AS customerNumber FROM `user` WHERE user_keyaccess = 0");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["customer"]  = $data[0]['customerNumber'];
}

$stmt = $con->prepare("SELECT 
    orders.order_id,
    orders.order_totalprice,
    orders.order_status,
    user.user_name,
    user.user_pfp
FROM 
    orders 
JOIN 
    user ON orders.order_userid = user.user_id
ORDER BY 
    orders.order_datetime DESC
LIMIT 5");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["orders"]  = $data;
}

$stmt = $con->prepare("SELECT 
    items.item_name,
    items.item_price,
    items.item_discount,
    items.item_img,
    COUNT(cart.cart_itemid) AS total_sold
FROM 
    items
JOIN 
    cart ON cart.cart_itemid = items.item_id
GROUP BY 
    items.item_name, items.item_price, items.item_discount
ORDER BY 
    total_sold DESC
LIMIT 20");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["topProducts"]  = $data;
}

$stmt = $con->prepare("WITH days_of_week AS (
    SELECT 'Sun' AS day_name, 1 AS day_num UNION ALL
    SELECT 'Mon' AS day_name, 2 AS day_num UNION ALL
    SELECT 'Tue' AS day_name, 3 AS day_num UNION ALL
    SELECT 'Wed' AS day_name, 4 AS day_num UNION ALL
    SELECT 'Thu' AS day_name, 5 AS day_num UNION ALL
    SELECT 'Fri' AS day_name, 6 AS day_num UNION ALL
    SELECT 'Sat' AS day_name, 7 AS day_num
),
computed AS (
    SELECT 
        d.day_name,
        IFNULL(SUM(o.order_totalprice), 0) AS total_sales,
        COUNT(o.order_totalprice) AS order_count,
        MOD(7 + d.day_num - (WEEKDAY(NOW()) + 2), 7) AS sort_order
    FROM days_of_week d
    LEFT JOIN `orders` o 
        ON d.day_name = LEFT(DAYNAME(o.order_datetime), 3)
        AND o.order_datetime BETWEEN DATE_SUB(NOW(), INTERVAL 1 WEEK) AND NOW()
    GROUP BY 
        d.day_name,
        d.day_num
)
SELECT * FROM computed
ORDER BY sort_order
");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["salesOverWeek"]  = $data;
}

$stmt = $con->prepare("SELECT 
    COUNT(cart.cart_itemid) AS 'Total_Selling',
    categories.category_name AS 'Category_name' 
FROM `cart`
JOIN `items` ON cart.cart_itemid = items.item_id
JOIN `categories` ON items.item_cat = categories.category_id
WHERE cart.cart_orderid > 0
GROUP BY categories.category_name;");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["topCategories"]  = $data;
}

$stmt = $con->prepare("SELECT 
    DATE_FORMAT(months.month_date, '%b') AS month_short,
    COALESCE(SUM(o.order_totalprice), 0) AS total_sales
FROM (
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 4 MONTH) AS month_date UNION ALL
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 3 MONTH) UNION ALL
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 2 MONTH) UNION ALL
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 1 MONTH) UNION ALL
    SELECT DATE_FORMAT(NOW(), '%Y-%m-01')
) AS months
LEFT JOIN orders o ON 
    DATE_FORMAT(o.order_datetime, '%Y-%m') = DATE_FORMAT(months.month_date, '%Y-%m')
    AND o.order_datetime >= DATE_SUB(NOW(), INTERVAL 5 MONTH)
GROUP BY 
    months.month_date, 
    DATE_FORMAT(months.month_date, '%b')
ORDER BY 
    months.month_date;");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["salesOverMonth"]  = $data;
}

$stmt = $con->prepare("SELECT COUNT(order_id) AS Orders_Number,order_status FROM `orders` GROUP BY order_status");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["Orders_Number"]  = $data;
}

$stmt = $con->prepare("SELECT 
    COUNT(delivery.delivery_id) AS 'Number_Of_Orders',
    user.user_name,
    user.user_pfp 
FROM `delivery` 
JOIN user ON delivery.delivery_workerid = user.user_id
GROUP BY 
    delivery.delivery_workerid,
    user.user_name,
    user.user_pfp");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    $alldata["Delivery_Workers"]  = $data;
}





echo json_encode($alldata);
