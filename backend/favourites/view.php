<?php
include "../connect.php";
$id = filterRequest("id");
getAllData("favourite", "favourite_userid = ?", array($id));
