<?php
include_once("dbconnect.php");

$useremail = $_POST['useremail'];

$sqlloadorder = "SELECT * FROM tbl_order WHERE payment_confirm = 'Done' AND order_confirm = 'None' ORDER BY order_date AND user_id ASC";

$result = $conn->query($sqlloadorder);

if ($result->num_rows > 0) {
     $orders["orders"] = array();

while ($row = $result->fetch_assoc()) {
        $orlist = array();
	    $orlist['orid'] = $row['order_id'];
	    $orlist['userid'] = $row['user_id'];
	    $orlist['username'] = $row['user_name'];
        $orlist['prname'] = $row['product_name'];
        $orlist['prqty'] = $row['product_qty'];
        $orlist['prdate'] = $row['order_date'];

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