<?php
error_reporting(0);
include_once("dbconnect.php");

$userid = $_GET['userid'];
$mobile = $_GET['mobile'];
$amount = $_GET['amount'];

$data = array(
    'id' =>  $_GET['billplz']['id'],
    'paid_at' => $_GET['billplz']['paid_at'] ,
    'paid' => $_GET['billplz']['paid'],
    'x_signature' => $_GET['billplz']['x_signature']
);

$paidstatus = $_GET['billplz']['paid'];
if ($paidstatus=="true"){
    $paidstatus = "Success";
}else{
    $paidstatus = "Failed";
}
$receiptid = $_GET['billplz']['id'];
$signing = '';
foreach ($data as $key => $value) {
    $signing.= 'billplz'.$key . $value;
    if ($key === 'paid') {
        break;
    } else {
        $signing .= '|';
    }
}
 
 
$signed= hash_hmac('sha256', $signing, 'S-kkC4BGA3Cs3ypDWIGG3SUQ');

if ($signed === $data['x_signature']) {
    if ($paidstatus == "Success"){ 
        //payment success
        
        $sqlinsert = "INSERT INTO user_order (user_email, amount) VALUES('$userid', '$amount')";
        $sqlupdate = "UPDATE tbl_order SET  payment_confirm = 'Done' WHERE user_email = '$userid' AND payment_confirm = 'None'";
        
        $stmt = $conn->prepare($sqlinsert);
        $stmt->execute();
        $stmtupd = $conn->prepare($sqlupdate);
        $stmtupd->execute();
        
        
        echo '<br><br><body><div><h2><br><br><center>Your Receipt</center>
         </h1>
         <table border=1 width=80% align=center>
         <tr><td>Receipt ID</td><td>'.$receiptid.'</td></tr><tr><td>Email to </td>
         <td>'.$userid. ' </td></tr><td>Amount </td><td>RM '.$amount.'</td></tr>
         <tr><td>Payment Status </td><td>'.$paidstatus.'</td></tr>
         <tr><td>Date </td><td>'.date("d/m/Y").'</td></tr>
         <tr><td>Time </td><td>'.date("h:i a").'</td></tr>
         </table><br>
         </div></body>';
        }
    else 
    {
        echo 'Payment Failed!';
    }
}

?>