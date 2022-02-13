import 'package:flutter/material.dart';
import 'package:annburger/model/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ndialog/ndialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserOrderMenu extends StatefulWidget {

  const UserOrderMenu({Key? key}) : super(key: key);

  @override
  State<UserOrderMenu> createState() => _UserOrderMenuState();
}

class _UserOrderMenuState extends State<UserOrderMenu> {
  late List _orderList = [];
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;

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
        title: const Text("Users' Order",
        style: TextStyle (fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
      body: RefreshIndicator(
        onRefresh: _loadOrder,
        child:  Column(children: [
         _orderList == null ?  const Flexible(
          child: Center(child: Text("No Data")),):
          const SizedBox(height:20),
          Text("Number of orders: " + _orderList.length.toString(),style: const TextStyle (fontSize: 20,fontWeight: FontWeight.bold )),
            const SizedBox(height:20),
             Flexible(
               child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _orderList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Container(
                                height: 50,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    border: Border.all(
                                      color: Colors.deepOrange,
                                    ),
                                    
                                  ),
                                child: 
                                Text("\t\t\t${_orderList[index]['prqty']} \t\tx\t\t${_orderList[index]['prname']}\t by\t\t${_orderList[index]['username']}",
                                style: const TextStyle (fontSize: 20))
                                ),
                                onTap: () =>{_completeOrderDialog(index)},);
                          }
                      )
            ),
             ),

               ),
            ]
        ),
        ),
      );  
  }
  Future<void> _loadOrder() async {
    var url = Uri.parse(Config.server + "/annburger/php/loaduserorder.php");
    var response = await http.get(url);
    var rescode = response.statusCode;
    if(rescode == 200){
      setState(() {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      _orderList = parsedJson['data']['orders'];
      textCenter = "Contain Data";
      }
      );
      } else {
        textCenter = "No data";
        return;
      } 
}
void _completeOrderDialog(int index) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Complete this order",
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
                _completeOrder(index);
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
  _completeOrder(int index) {

    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Updating order.."),
        title: const Text("Processing..."));
    progressDialog.show();
    http.post(Uri.parse(Config.server + "/annburger/php/completeorder.php"),
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
        _loadOrder;
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
}