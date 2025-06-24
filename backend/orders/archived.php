<?php

include "../connect.php";

$userid = filterRequest("userID");

getAllData("orders","order_userid = '$userid' AND order_status = 6 ORDER BY order_status ASC");