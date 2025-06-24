<?php

define("MB", 1048576);

function filterRequest($requestname)
{
    return  htmlspecialchars(strip_tags($_POST[$requestname]));
}

function getAllData($table, $where = null, $values = null, $json = true)
{
    global $con;
    $data = array();
    if ($where == null) {
        $stmt = $con->prepare("SELECT * FROM $table ");
    } else {
        $stmt = $con->prepare("SELECT * FROM $table WHERE $where ");
    }
    $stmt->execute($values);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($json) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "failure"));
        }
        return $count;
    } else {
        if ($count > 0) {
            return $data;
        } else {
            return json_encode(array("status" => "failure"));
        }
    }
}

function getData($table, $where = null, $values = null)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE $where ");
    $stmt->execute($values);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "success", "data" => $data));
    } else {
        echo json_encode(array("status" => "failure"));
    }
    return $count;
}

function insertData($table, $data, $json = true)
{
    global $con;
    foreach ($data as $field => $v)
        $ins[] = ':' . $field;
    $ins = implode(',', $ins);
    $fields = implode(',', array_keys($data));
    $sql = "INSERT INTO $table ($fields) VALUES ($ins)";

    $stmt = $con->prepare($sql);
    foreach ($data as $f => $v) {
        $stmt->bindValue(':' . $f, $v);
    }
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}


function updateData($table, $data, $where, $json = true)
{
    global $con;
    $cols = array();
    $vals = array();

    foreach ($data as $key => $val) {
        $vals[] = "$val";
        $cols[] = "`$key` =  ? ";
    }
    $sql = "UPDATE $table SET " . implode(', ', $cols) . " WHERE $where";

    $stmt = $con->prepare($sql);
    $stmt->execute($vals);
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}

function deleteData($table, $where, $json = true)
{
    global $con;
    $stmt = $con->prepare("DELETE FROM $table WHERE $where");
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}

function imageUpload($dir, $imageRequest)
{
    global $msgError;
    if (isset($_FILES[$imageRequest])) {
        $imagename  = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
        $imagetmp   = $_FILES[$imageRequest]['tmp_name'];
        $imagesize  = $_FILES[$imageRequest]['size'];
        $allowExt   = array("jpg", "png", "gif", "mp3", "pdf", "svg");
        $strToArray = explode(".", $imagename);
        $ext        = end($strToArray);
        $ext        = strtolower($ext);

        if (!empty($imagename) && !in_array($ext, $allowExt)) {
            $msgError = "EXT";
        }
        if ($imagesize > 2 * MB) {
            $msgError = "size";
        }
        if (empty($msgError)) {
            move_uploaded_file($imagetmp,  $dir . "/" . $imagename);
            return $imagename;
        } else {
            return "fail";
        }
    } else {
        return "empty";
    }
}



function deleteFile($dir, $imagename)
{
    if (file_exists($dir . "/" . $imagename)) {
        unlink($dir . "/" . $imagename);
    }
}

function checkAuthenticate()
{
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "wael" ||  $_SERVER['PHP_AUTH_PW'] != "wael12345") {
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
}
function printFail($message = "null")
{
    echo json_encode(array("status" => "failure", "meesage" => $message));
}

function printSuccess($message = "null")
{
    echo json_encode(array("status" => "success", "meesage" => $message));
}

function results($count, $Failmessage = "null", $Sucmessage = "null")
{
    if ($count > 0) {
        printSuccess($Sucmessage);
    } else {
        printFail($Failmessage);
    }
}

function sendEmail($to, $title, $body)
{
    $header = "From support@mw.com" . "/n" . "CC: abdulwahedaldaghir0@gmail.com";
    mail($to, $title, $body, $header);
}

function getCount($count, $table, $where = null, $values = null)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT COUNT($count) as countitem FROM $table WHERE $where ");
    $stmt->execute($values);
    $data = $stmt->fetchColumn();
    $count  = $stmt->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "success", "data" => $data));
    } else {
        echo json_encode(array("status" => "success", "data" => "0"));
    }
}

function getOnly($table, $select, $where = null, $values = null)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT $select FROM $table WHERE $where ");
    $stmt->execute($values);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "success", "data" => $data));
    } else {
        echo json_encode(array("status" => "failure"));
    }
    return $count;
}

function returnData($table, $where = null, $values = null, $json = false)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE $where ");
    $stmt->execute($values);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    $result = array("status" => "success", "data" => $data);
    if ($json) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $result;
}

require 'vendor/autoload.php'; // for Google Client

function sendFCM(
    $title,
    $message,
    $topic,
    $pageid,
    $pagename,
    $imageUrl = null,
    $icon = null,
    $sound = "default",
    $color = "#FF0000",
    $route = "/home",
    $badge = 0,
    $priority = "high"
) {
    $projectId = ''; // Replace with your Firebase project ID


    $client = new \Google_Client();
    $client->setAuthConfig(__DIR__ . '/service-account.json');
    $client->addScope('https://www.googleapis.com/auth/firebase.messaging');
    $client->useApplicationDefaultCredentials();

    $token = $client->fetchAccessTokenWithAssertion()['access_token'];

    $url = "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";

    $messageData = [
        "message" => [
            "topic" => $topic,
            "notification" => [
                "title" => $title,
                "body" => $message,
            ],
            "data" => [
                "pageid" => $pageid,
                "pagename" => $pagename,
                "route" => $route,
                "image" => $imageUrl,
            ],
            "android" => [
                "priority" => $priority,
                "notification" => [
                    "icon" => $icon,
                    "color" => $color,
                    "sound" => $sound,
                    "image" => $imageUrl,
                    "channel_id" => "high_priority_channel",
                ],
            ],
            "apns" => [
                "payload" => [
                    "aps" => [
                        "sound" => "$sound.caf",
                        "badge" => $badge,
                        "mutable-content" => 1,
                    ],
                ],
                "fcm_options" => [
                    "image" => $imageUrl,
                ],
            ],
        ],
    ];

    $headers = [
        "Authorization: Bearer $token",
        "Content-Type: application/json",
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($messageData));

    $result = curl_exec($ch);
    curl_close($ch);

    return $result;
}

function sendToNotification(
    $title,
    $body,
    $userID,
    $pageid,
    $pagename,
    $imageUrl = null,
    $icon = null,
    $sound = "default",
    $color = "#FF0000",
    $route = "/home",
    $badge = 0,
    $priority = "high"
) {
    $data = array(
        "notification_title" => $title,
        "notification_body" => $body,
        "notification_userid" => $userID,
        "notification_image" => $imageUrl
    );
    if ($icon != null) {
        $data["notification_icon"] = $icon . ".svg";
    }

    insertData("notification", $data, false);

    return sendFCM(
        $title,
        $body,
        "user_" . $userID,
        $pageid,
        $pagename,
        $imageUrl,
        $icon,
        $sound,
        $color,
        $route,
        $badge,
        $priority
    );
}


function getOne($table, $where = null, $values = null, $json = true)
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE $where ");
    $stmt->execute($values);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($json) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "failure"));
        }
        return $count;
    } else {
        if ($count > 0) {
            return $data;
        } else {
            return json_encode(array("status" => "failure"));
        }
    }
}


function sendNotifications(
    $keyaccess,
    $title,
    $body,
    $pageid,
    $pagename,
    $imageUrl = null,
    $icon = null,
    $sound = "default",
    $color = "#FF0000",
    $route = "/home",
    $badge = 0,
    $priority = "high",
    $json = false
) {
    global $con;
    $stmt = $con->prepare("SELECT user_id FROM user WHERE user_keyaccess = :keyaccess");
    $stmt->bindParam(':keyaccess', $keyaccess);
    $stmt->execute();
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $success = false;

    foreach ($users as $row) {
        $user_id = 'user_' . $row['user_id'];
        $response = sendToNotification(
            $title,
            $body,
            str_replace("user_", "", $user_id),
            $pageid,
            $pagename,
            $imageUrl,
            $icon,
            $sound,
            $color,
            $route,
            $badge,
            $priority
        );


        if ($response && strpos($response, 'message') !== false) {
            $success = true;
        }
    }

    if ($json) {
        if ($success) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
}

function generateUniqueUserId()
{
    global $con;
    do {
        $id = random_int(0, 2147483647);
        $stmt = $con->prepare("SELECT COUNT(*) FROM user WHERE user_id = ?");
        $stmt->execute([$id]);
        $count = $stmt->fetchColumn();
    } while ($count > 0);

    return $id;
}
