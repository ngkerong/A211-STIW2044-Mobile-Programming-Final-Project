import 'package:flutter/material.dart';
import 'package:annburger/model/user.dart';
import 'package:annburger/model/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgressOrderPage extends StatefulWidget {

  final User user;
  const ProgressOrderPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProgressOrderPage> createState() => _ProgressOrderPageState();
}

class _ProgressOrderPageState extends State<ProgressOrderPage> {
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
        title: const Text("Current Progress",
        style: TextStyle (fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
      body: RefreshIndicator(
        onRefresh: _loadOrder,
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
                            return Container(
                                height: 50,
                                color: Colors.amber[100],
                                alignment: Alignment.centerLeft,
                                child: Text("\t\t\t${_orderList[index]['prqty']} \t\tx\t\t${_orderList[index]['prname']}",
                                style: const TextStyle (fontSize: 20)));
                            
                            
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
    String _useremail = widget.user.email.toString(); 

    http.post(Uri.parse(Config.server + "/annburger/php/loadprogressorder.php"), 
    body: {
      "useremail": _useremail,
    }).then((response) {
      var rescode = response.statusCode;
    if(rescode == 200){
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      _orderList = parsedJson['data']['orders'];
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