import 'package:flutter/material.dart';
import 'package:annburger/model/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle; 
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'dart:convert';
import 'loginpage.dart';


class RegisterAdminPage extends StatefulWidget {
  const RegisterAdminPage({Key? key}) : super(key: key);

  @override
  State<RegisterAdminPage> createState() => _RegisterAdminPageState();
}

class _RegisterAdminPageState extends State<RegisterAdminPage> {

  
  late double screenHeight, screenWidth;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  bool _passwordVisible = true;  
  bool _isChecked = false;
  String eula = "";

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
    body: Stack(
      children: [
        upperHalf(context),
        lowerHalf(context)
      ],
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.orangeAccent,
      height: screenHeight/4,
      width: screenWidth,
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: 600,
      margin: EdgeInsets.only(top: screenHeight / 4),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.orangeAccent[100],
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
                  child: Form(
                    key: _fromKey,
                    child:  Column(
                      children: <Widget> [
                        const Text(
                        "Register New Admin Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (val) => val!.isEmpty || (val.length < 3)
                          ? "Username must be longer than 3"
                          :null,
                          onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus);
                          },
                          controller: _nameEditingController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.grey[700],
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: Colors.grey,),
                          icon: Icon(Icons.person, color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,width:2.0),
                          )
                          ),
                      ),
                      const SizedBox(
                        height: 5,),
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (val) => val!.isEmpty || !val.contains("@") || !val.contains(".")
                          ? "Enter a valid email"
                          : null,
                          onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus1);
                          },
                          controller: _emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.grey[700],
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.grey,),
                          icon: Icon(Icons.mail, color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,width:2.0),
                          )
                          ),
                      ),
                      const SizedBox(
                        height: 5,
                        ),
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (val) => validatePassword(val.toString()),
                          onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus2);
                          },
                          controller: _passEditingController,
                          cursorColor: Colors.grey[700],
                          decoration:  InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Colors.grey,),
                          icon: const Icon(Icons.lock, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: (){
                              setState((){
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,width:2.0),
                          )
                          ),
                          obscureText: _passwordVisible,
                      ),
                      const SizedBox(
                        height: 5,
                        ), 
                      TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            validatePassword(val.toString());
                            if (val != _passEditingController.text){
                                return "Please enter same password";
                            }else{
                                return null;
                            }
                          },
                          onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus3);
                          },
                          controller: _pass2EditingController,
                          cursorColor: Colors.grey[700],
                          decoration: InputDecoration(
                            labelText: 'Re-Enter Password',
                            labelStyle: const TextStyle(
                              color: Colors.grey,),
                          icon: const Icon(Icons.lock, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: (){
                              setState((){
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,width:2.0),
                          )
                          ),
                        obscureText: _passwordVisible,
                      ),
                      const SizedBox(
                        height: 5,
                        ), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value){
                              setState(() {
                                _isChecked = value!;
                              });
                            }
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: _showEULA,
                              child: const Text('Agree with terms',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                              ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                            minWidth: 80,
                            height: 30,
                            child: const Text('Register'),
                            color: Colors.orange[800],
                            textColor: Colors.white,
                            elevation: 10, 
                            onPressed: _registerAccountDialog, 
                          ),
                        ],
                      ),
                    ],
                    ),
                    ),
                    ),
                    ),
                    const SizedBox(
                      height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Already Register? ",
                                style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                          GestureDetector(
                                onTap: () => {
                                  Navigator.pushReplacement(context, 
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const LoginPage() ))
                                },
                                child: const Text("Login here",
                                style: TextStyle(
                                  fontSize: 16.0, 
                                  color: Colors.black),
                                ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 5,
                    ),     
          ],
        ),
      ),
    );
  }
void _registerAccountDialog() {
    if (!_fromKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please complete the registration form first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept the terms and conditions",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
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
                _registerUserAccount();
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
  void _registerUserAccount() {
    FocusScope.of(context).requestFocus(FocusNode());
    String _name = _nameEditingController.text;
    String _email = _emailEditingController.text;
    String _pass = _passEditingController.text;
    String _type = "admin";
    FocusScope.of(context).unfocus();
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Registration in progress.."),
        title: const Text("Registering..."));
    progressDialog.show();

    http.post(Uri.parse(Config.server + "/annburger/php/register_user.php"),
        body: {
          "name": _name,
          "email": _email,
          "password": _pass,
          "type": _type
        }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Registration Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Registration Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        return;
      }
    });
  }
  String? validatePassword(String password) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
     RegExp regex = RegExp(pattern);
    if (password.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }   
  }
  loadEula() async {
    eula = await rootBundle.loadString('assets/images/eula.txt');
  } 
  void _showEULA() {
    loadEula();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "EULA",
          ),
          content: SizedBox(
            height: screenHeight / 1.5,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12.0,
                          color:Colors.black,
                        ),
                        text: eula),
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
 
          


          