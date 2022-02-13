<?php
include_once("dbconnect.php");

$user_email = $_POST['user_email'];

$sqlloadpayment = "SELECT * FROM user_order WHERE user_email = '$user_email' ORDER BY date DESC";

$result = $conn->query($sqlloadpayment);

if ($result->num_rows > 0) {
     $payments["payments"] = array();

while ($row = $result->fetch_assoc()) {
        $paymentlist = array();
	    $paymentlist['order_no'] = $row['order_no'];
	    $paymentlist['user_email'] = $row['user_email'];
	    $paymentlist['amount'] = $row['amount'];
        $paymentlist['date'] = $row['date'];

        array_push($payments["payments"],$paymentlist);
    }
     $response = array('status' => 'success', 'data' => $payments);
    sendJsonResponse($response);

}else{

    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>