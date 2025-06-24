<?php

include "../connect.php";

$table = "rating";

$userid = filterRequest("userid");
$rateid = filterRequest("rateid");

deleteData($table,"rating_id = '$rateid'");