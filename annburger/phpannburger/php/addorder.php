<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$username = $_POST['username'];
$useremail = $_POST['useremail'];
$prid = $_POST['prid'];
$prname = $_POST['prname'];
$prqty = $_POST['prqty'];
$totalprice = $_POST['totalprice'];
$paymentfirm = $_POST['paymentfirm'];
$orderfirm = $_POST['orderfirm'];

$sqlinsert = "INSERT INTO tbl_order (user_id,user_name,user_email,product_id,product_name,product_qty,total_price,payment_confirm,order_confirm) 
VALUES('$userid', '$username', '$useremail', '$prid', '$prname', '$prqty', '$totalprice', '$paymentfirm', '$orderfirm')";
if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>
