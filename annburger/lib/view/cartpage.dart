import 'package:flutter/material.dart';
import 'package:annburger/model/user.dart';
import 'package:annburger/model/config.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'billpage.dart';
import 'dart:convert';



class CartPage extends StatefulWidget {
  final User user;
  const CartPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List _orderList = [];
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;
  late double _totalprice = 0.00;
  late List givenList = _orderList;

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Page",
        style: TextStyle (fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
      body: Container(
        child:  Column(children: [
         _orderList == null ?  const Flexible(
          child: Center(child: Text("No Data")),):
             Flexible(
               child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _orderList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Table(
                                border: const TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
                                columnWidths: const <int, TableColumnWidth>{
                                  0: IntrinsicColumnWidth(),
                                  1: FlexColumnWidth(),
                                  2: FixedColumnWidth(64),
                                },
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(
                                    children: <Widget>[
                                      Container(
                                        width: screenWidth/5,
                                        height: screenHeight/12,
                                        child: Align(
                                        alignment: Alignment.center,
                                        child: Text('${_orderList[index]['prname']}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle (fontSize: 15,color: Colors.orange,fontWeight: FontWeight.bold )))),
                                        const SizedBox(height:0.1),
                                        Text('${_orderList[index]['prqty']} qty',style: const TextStyle (fontSize: 15,fontWeight: FontWeight.bold )),
                                        Text('RM ' + double.parse(_orderList[index]['totalprice']).toStringAsFixed(2),style: const TextStyle (fontSize: 15,fontWeight: FontWeight.bold )),
                                        IconButton(icon: const Icon(Icons.delete,color: Colors.black,), 
                                                  onPressed: (){
                                                    _deleteOrderDialog(index);
                                                  }),
                                    ],),
                                    
                                    ]);
                            
                          }
                      )
            ),
             ),

               ),
            
            
               Text("Total price: RM " + double.parse(_totalprice.toString()).toStringAsFixed(2),style: const TextStyle (fontSize: 20,fontWeight: FontWeight.bold )),
               ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth/2, screenHeight / 20)),
                    child: const Text('Add Order'),
                    onPressed: () => {
                      _PaymentDialog(),})]
        ),
        ),
      );  
  }
  Future<void> _loadOrder() async {
    String _useremail = widget.user.email.toString(); 
    String _paymentfirm = "None";

    http.post(Uri.parse(Config.server + "/annburger/php/loadorder.php"), 
    body: {
      "useremail": _useremail,
      "paymentfirm": _paymentfirm,
    }).then((response) {
      var rescode = response.statusCode;
    if(rescode == 200){
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      _orderList = parsedJson['data']['orders'];
      textCenter = "Contain Data";

      setState(() {
      for (int i = 0; i < givenList.length; i++) {
        _totalprice += double.parse(givenList[i]['totalprice']);      
        }
      }
      );
      } else {
        textCenter = "No data";
        return;
      } 
    });
  }

 void _deleteOrderDialog(int index) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Delete this product",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteOrder(index);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }
  _deleteOrder(int index) {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Deleting order.."),
        title: const Text("Processing..."));
    progressDialog.show();
    http.post(Uri.parse(Config.server + "/annburger/php/deleteorder.php"),
        body: {
          "orid": _orderList[index]['orid'],
          
        }).then((response) {
      var data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        Navigator.of(context).pop();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        return;
      }
    });
  } 
   _PaymentDialog() {
    if (_totalprice == 0.00) {
      Fluttertoast.showToast(
          msg: "Please select some products to purchase",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      Navigator.of(context).pop();
      return;
    }else{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Start the payment",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>BillPage(
                            email:widget.user.email.toString(),
                            name: widget.user.name.toString(),
                            totalprice:_totalprice.toString(),
                )));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
   }
  }