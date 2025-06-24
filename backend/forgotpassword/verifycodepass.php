<?php
include "../connect.php";
$email = filterRequest("email");
$verify = filterRequest("veridycode");
$stmt = $con->prepare("SELECT * FROM USER WHERE user_email = '$email' AND user_verifycode = '$verify'");
$stmt->execute();
$count = $stmt->rowCount();
results($count);