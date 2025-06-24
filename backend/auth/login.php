<?php
include "../connect.php";

$username = filterRequest("username");
$password = sha1($_POST["password"]);
    
getData("user","user_name = ? AND user_password = ? ",array($username, $password));