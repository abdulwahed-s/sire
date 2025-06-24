<?php

include "../connect.php";

$table = "address";

$userid = filterRequest("userid");
$addressname = filterRequest("addressname");
$buildingname = filterRequest("buildingname");
$aptnumber = filterRequest("aptnumber");
$floor = filterRequest("floor");
$street = filterRequest("street");
$block = filterRequest("block");
$way = filterRequest("way");
$additional = filterRequest("additional");
$bymap = filterRequest("bymap");
$deliverytime = filterRequest("deliverytime");
$marker = filterRequest("marker");
$lat = filterRequest("lat");
$long = filterRequest("long");

$data = array(
    "address_userid" => $userid,
    "address_name" => $addressname,
    "address_building" => $buildingname,
    "address_apt" => $aptnumber,
    "address_floor" => $floor,
    "address_street" => $street,
    "address_block" => $block,
    "address_way" => $way,
    "address_additional" => $additional,
    "address_bymap" => $bymap,
    "address_deliverytime" => $deliverytime,
    "address_marker" => $marker,
    "address_lat" => $lat,
    "address_long" => $long,
);

insertData($table, $data);
