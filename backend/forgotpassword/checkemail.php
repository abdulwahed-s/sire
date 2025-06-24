<?php
include "../connect.php";

$email = filterRequest("email");
$verifycode = rand(100000, 999999);


$stmt = $con->prepare("SELECT * FROM user WHERE user_email = ?");
$stmt->execute(array($email));
$count = $stmt->rowCount();
results($count);
if($count>0){
$data = array("user_verifycode"=>$verifycode);
updateData("user", $data, "user_email = '$email'",false);
// sendEmail($email, "Verify your account", "Verify code : $verifycode");
}