<?php
include "../connect.php";

$id = generateUniqueUserId();
$username = filterRequest("username");
$email = filterRequest("email");
$phonenumber = filterRequest("phonenumber");
$password = sha1($_POST["password"]);
$verifycode = rand(100000, 999999);

$stmt1 = $con->prepare("SELECT * FROM user WHERE user_email = ?");
$stmt1->execute(array($email));
$count1 = $stmt1->rowCount();

$stmt2 = $con->prepare("SELECT * FROM user WHERE user_name = ?");
$stmt2->execute(array($username));
$count2 = $stmt2->rowCount();

$stmt3 = $con->prepare("SELECT * FROM user WHERE user_phone = ?");
$stmt3->execute(array($phonenumber));
$count3 = $stmt3->rowCount();


if ($count1 > 0) {
    echo json_encode(array("status" => "emailfail"));
} else if ($count2 > 0) {
    echo json_encode(array("status" =>  "userfail"));
} else if ($count3 > 0) {
    echo json_encode(array("status" => "phonefail"));
} else {
    $data = array(
        "user_id" => $id,
        "user_name" => $username,
        "user_email" => $email,
        "user_phone" => $phonenumber,
        "user_password" => $password,
        "user_verifycode" => $verifycode,
        "user_pfp" => 'default.png',
        "user_banner" => 'default.png',

    );
    // sendEmail($email, "Verify your account", "Verify code : $verifycode");
    insertData("user", $data);
}
