import 'package:flutter/material.dart';
import 'package:annburger/model/user.dart';
import 'package:annburger/model/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentHistoryPage extends StatefulWidget {

  
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  late List _paymentList = [];
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;
  double earn = 0.0;

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
      body: RefreshIndicator(
        onRefresh: _loadPayment,
        child:  Column(children: [
         _paymentList == null ?  const Flexible(
          child: Center(child: Text("No Data")),):
          const SizedBox(height:20),
          Text('Total Earn: RM ' + double.parse(earn.toString()).toStringAsFixed(2),style: const TextStyle (fontSize: 20,fontWeight: FontWeight.bold )),
            const SizedBox(height:15),
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
                                        height: screenHeight/8,
                                        child: Align(
                                        alignment: Alignment.center,
                                        child: Text(_paymentList[index]['date'].toString() + '\n\n' +_paymentList[index]['user_email'].toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle (fontSize: 15,fontWeight: FontWeight.bold )))),
                                      Container(
                                        width: screenWidth/2,
                                        height: screenHeight/12,
                                        child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('+ RM ' + double.parse(_paymentList[index]['amount']).toStringAsFixed(2),
                                        textAlign: TextAlign.right,
                                        style: const TextStyle (fontSize: 20,fontWeight: FontWeight.bold, color: Colors.green )))),
                                      
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

    var url = Uri.parse(Config.server + "/annburger/php/loadpayment.php");
    var response = await http.get(url);
    var rescode = response.statusCode;
    if(rescode == 200){
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      _paymentList = parsedJson['data']['payments'];
      textCenter = "Contain Data";
      
      setState(() {
      for (int i = 0; i < _paymentList.length; i++) {
        earn += double.parse(_paymentList[i]['amount']);      
        }
      }
      );
      } else {
        textCenter = "No data";
        return;
      }
  }
}