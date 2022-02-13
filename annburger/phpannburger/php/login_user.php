<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    echo "failed";
    die();
}
include_once("dbconnect.php");

$email = $_POST['email'];
$password = sha1($_POST['password']);
$type = $_POST['type'];
$sqllogin = "SELECT * FROM register_user WHERE user_email = '$email' AND user_password = '$password' AND user_type = '$type'";

$result = $conn->query($sqllogin);
if ($result->num_rows > 0) {
while ($row = $result->fetch_assoc()) {
        $userlist = array();
        $userlist['id'] = $row['user_id'];
        $userlist['name'] = $row['user_name'];
        $userlist['email'] = $row['user_email'];
        $userlist['regdate'] = $row['user_regdate'];
        $userlist['otp'] = $row['user_otp'];
	$userlist['type'] = $row['user_type'];
        echo json_encode($userlist);
        $conn->close();
        return;
    }
}else{
    echo "failed";
}
?>