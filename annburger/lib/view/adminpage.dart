import 'package:flutter/material.dart';
import 'registeradminpage.dart';
import 'loginpage.dart';
import 'package:annburger/model/user.dart';
import 'package:annburger/view/paymenthistory.dart';


class AdminPage extends StatefulWidget {

  final User user;
  const AdminPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page",
        style: TextStyle (fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
    body: Center(
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Card( 
            elevation: 5,
            child: Row( 
          children:[
               const SizedBox(width:30),
               Container(
                  color:Colors.amber[200],
                  alignment: Alignment.center,
                  child: const Text(
                    "Admin ID" + "\n\n" +
                    "Name" + "\n\n" + 
                    "Email",
                    style: TextStyle (fontSize: 20,fontWeight: FontWeight.bold ),
                  ),
        ),const SizedBox(width:15),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                     widget.user.id.toString() + "\n\n" + 
                     widget.user.name.toString() + "\n\n" + 
                     widget.user.email.toString(),
                     style: const TextStyle (fontSize: 20),
                  ),
          )]),
          )),
          Flexible(
            flex: 6,
            child: Column(
              children: [
                  Container(
                        color: Colors.amber,
                        child: const Center(
                          child: Text("SETTINGS",
                          style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                        ),
                  ),
                  Expanded(
                      child: ListView(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          shrinkWrap: true,
                          children: [
                         MaterialButton(
                          onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                          PaymentHistoryPage()));},
                          child: const Text("PAYMENT HISTORY"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: _registerAccountDialog,
                          child: const Text("NEW ADMIN REGISTRATION"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                         MaterialButton(
                          onPressed: _loginAccountDialog,
                          child: const Text("LOGOUT"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                      ])),
                ],
          )),
        ]
    )));
  }

void _registerAccountDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:  const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new Account",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blueAccent,
                  ),
                ),
  
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                             const RegisterAdminPage()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.blueAccent,
                  ),
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
  void _loginAccountDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:  const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Logout",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blueAccent,
                  ),
                ),
  
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                             const LoginPage()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.blueAccent,
                  ),
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