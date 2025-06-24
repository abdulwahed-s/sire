<?php
include "../connect.php";
$email = filterRequest("email");
$verify = filterRequest("veridycode");
$stmt = $con->prepare("SELECT * FROM USER WHERE user_email = '$email' AND user_verifycode = '$verify'");
$stmt->execute();
$count = $stmt->rowCount();
if ($count > 0) {
    $data = array("user_approve" => 1);
    updateData("user", $data, "user_email = '$email'");
} else {
    printFail("Verify code is wrong");
}
