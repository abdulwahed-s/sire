<?php
include "../connect.php";
$email = filterRequest("email");
$verifycode = rand(100000, 999999);
updateData("user", array("user_verifycode" => $verifycode), "user_email = '$email'");

?>