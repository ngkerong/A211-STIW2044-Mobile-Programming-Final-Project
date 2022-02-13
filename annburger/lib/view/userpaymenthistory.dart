import 'package:flutter/material.dart';
import 'package:annburger/model/user.dart';
import 'package:annburger/model/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserPaymentHistoryPage extends StatefulWidget {

  final User user;
  const UserPaymentHistoryPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserPaymentHistoryPage> createState() => _UserPaymentHistoryPageState();
}

class _UserPaymentHistoryPageState extends State<UserPaymentHistoryPage> {
  late List _paymentList = [];
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;
  late List date;

  @override
  void initState() {
    super.initState();
    _loadPayment();
  }

  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment History",
        style: TextStyle (fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
      body: Container(
        child:  Column(children: [
         _paymentList == null ?  const Flexible(
          child: Center(child: Text("No Data")),):

             Flexible(
               child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _paymentList.length,
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
                                        width: screenWidth/2,
                                        height: screenHeight/12,
                                        child: Align(
                                        alignment: Alignment.center,
                                        child: Text(_paymentList[index]['date'].toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle (fontSize: 15,fontWeight: FontWeight.bold )))),
                                      Container(
                                        width: screenWidth/2,
                                        height: screenHeight/12,
                                        child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('- RM ' + double.parse(_paymentList[index]['amount']).toStringAsFixed(2),
                                        textAlign: TextAlign.right,
                                        style: const TextStyle (fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red )))),
                                      
                                    ],),
                                    
                                    ]);
                            
                            
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
  Future<void> _loadPayment() async {

    String _useremail = widget.user.email.toString(); 

    http.post(Uri.parse(Config.server + "/annburger/php/loaduserpayment.php"), 
    body: {
      "user_email": _useremail,
    }).then((response) {
      var rescode = response.statusCode;
    if(rescode == 200){
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      _paymentList = parsedJson['data']['payments'];
      textCenter = "Contain Data";

      setState(() {
    
      }
      );
      } else {
        textCenter = "No data";
        return;
      } 
    });
  }
}