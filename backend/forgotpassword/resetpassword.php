<?php

include "../connect.php";

$email = filterRequest("email");
$verify = filterRequest("veridycode");
$password = sha1($_POST["password"]);
$data = array("user_password" => $password);
$count = updateData("user", $data, "user_email =  '$email' AND user_verifycode = '$verify'", json: false);
if ($count > 0) {
    getData("user", "user_email = ? AND user_password = ? ", array($email, $password));
} else {
    echo json_encode(array("status" => "failure"));
}
