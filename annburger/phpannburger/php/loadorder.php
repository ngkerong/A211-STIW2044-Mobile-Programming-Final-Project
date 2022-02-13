<?php
include_once("dbconnect.php");

$useremail = $_POST['useremail'];
$paymentfirm = $_POST['paymentfirm'];
$sqlloadorder = "SELECT * FROM tbl_order WHERE user_email = '$useremail' AND payment_confirm = '$paymentfirm' ";
$result = $conn->query($sqlloadorder);

if ($result->num_rows > 0) {
     $orders["orders"] = array();

while ($row = $result->fetch_assoc()) {
        $orlist = array();
	$orlist['orid'] = $row['order_id'];
        $orlist['prname'] = $row['product_name'];
        $orlist['prqty'] = $row['product_qty'];
	$orlist['totalprice'] = $row['total_price'];

        array_push($orders["orders"],$orlist);
    }
     $response = array('status' => 'success', 'data' => $orders);
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