<?php

include "../connect.php";

$table = "rating";

$userid = filterRequest("userid");
$itemid = filterRequest("itemid");
$stars = filterRequest("stars");
$comment = filterRequest("comment");

$data = array(
    "rating_userid" => $userid,
    "rating_itemid" => $itemid,
    "rating_stars" => $stars,
    "rating_comment" => $comment
);

insertData($table,$data);