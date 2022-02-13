import 'package:flutter/material.dart';
import 'package:annburger/model/product.dart';
import 'package:annburger/model/user.dart';
import 'package:annburger/model/config.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';


class DetailPage extends StatefulWidget {
  final Product product;
  final User user;
  const DetailPage({Key? key, required this.user, required this.product}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late double screenHeight, screenWidth;
  int n = 1;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page",
        style: TextStyle (fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget>[
          const SizedBox(height:10),
           CachedNetworkImage(
              height: screenHeight / 4,
              width: screenWidth / 2,
              imageUrl: Config.server + "/annburger/images/products/${widget.product.prid.toString()}.png"),
      const SizedBox(height:20),
          Row( 
          children:[
               const SizedBox(width:30),
               Container(
                  color:Colors.amber[200],
                  alignment: Alignment.center,
                  child: const Text(
                    "Name" + "\n\n" + 
                    "Price per 1",
                    style: TextStyle (fontSize: 20,fontWeight: FontWeight.bold ),
                  ),
        ),const SizedBox(width:15),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                     widget.product.prname.toString() + "\n\n" + 
                     "RM " + double.parse(widget.product.prprice.toString()).toStringAsFixed(2),
                     style: const TextStyle (fontSize: 20),
                  ),
          )]),const SizedBox(height:20),
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.amber[100],
                width: screenWidth,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description\n\n" + widget.product.prdesc.toString(),
                   style: const TextStyle (fontSize: 20 )),
                  
                ),const SizedBox(height:5),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 const Text(
                  "Add quantity prodoct",
                   style: TextStyle (fontSize: 20,fontWeight: FontWeight.bold )),
             FloatingActionButton(
              onPressed: add,
              child: const Icon(Icons.add, color: Colors.black,),
              backgroundColor: Colors.white,),

            Text('$n',style: const TextStyle(fontSize: 20)),

            FloatingActionButton(
              onPressed: minus,
              child: const Icon(Icons.remove, color: Colors.black,),
              backgroundColor: Colors.white,),
          ],),const SizedBox(height:20),
          ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenWidth/2, screenHeight / 13)),
                          child: const Text('Add Order'),
                          onPressed: () => {_newOrderDialog()}
                          
                        ),
          ]),),
        );
  }
  void add() {
  setState(() {
    n++;
  });
}

void minus() {
  setState(() {
    if (n != 1) {
      n--;
    }
  });
}
void _newOrderDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Add this product",
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
                _addOrder();
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
 void _addOrder() {
    String _userid = widget.user.id.toString(); 
    String _username = widget.user.name.toString();
    String _useremail = widget.user.email.toString();
    String _prid = widget.product.prid.toString();
    String _prname = widget.product.prname.toString();
    String _prqty = n.toString();
    String _totalprice = (double.parse(widget.product.prprice.toString()) * n).toString();
    String _paymentfirm = "None";
    String _orderfirm = "None";

    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Adding order.."),
        title: const Text("Processing..."));
    progressDialog.show();

    http.post(Uri.parse(Config.server + "/annburger/php/addorder.php"), 
    body: {
      "userid": _userid,
      "username": _username,
      "useremail": _useremail,
      "prid": _prid,
      "prname": _prname,
      "prqty": _prqty,
      "totalprice":_totalprice,
      "paymentfirm": _paymentfirm,
      "orderfirm": _orderfirm,
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
      }else{
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
    progressDialog.dismiss();
  }
}