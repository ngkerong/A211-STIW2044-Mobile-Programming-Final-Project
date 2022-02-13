import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:annburger/model/config.dart';
import 'package:annburger/view/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'mainpage1.dart';
import 'mainpage2.dart';
import 'package:annburger/model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double screenHeight, screenWidth;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _passwordVisible = true;
  String type = "user";
  List<String> typelist = [
     "user",
     "admin"
   ];

  @override
  void initState() {
    super.initState(); 
    loadPref();
  }

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

  Widget lowerHalf(BuildContext context){
    return Container(
      color: Colors.amber,
      height: 600,
      margin: EdgeInsets.only(top: screenHeight/4),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.orangeAccent[100],
              elevation: 10,
              child: Container(
                padding:  const EdgeInsets.fromLTRB(25,10,20,25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children:  [
                       const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          ),
                      ),
                       const SizedBox(height: 10,
                      ),
                      DropdownButton(
              itemHeight: 60,
              value: type,
              onChanged: (newValue){
                setState((){
                  type = newValue.toString();
                });
              },
              items: typelist.map((type){
                return DropdownMenuItem(
                  child : Text(
                    type,
                  ),
                value: type,
                );
              }).toList(),
          ),const SizedBox(height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty || !val.contains("@") || !val.contains(".")
                          ?"Please enter a valid email"
                          : null,
                        focusNode: focus,
                        onFieldSubmitted: (v) { 
                          FocusScope.of(context).requestFocus(focus1);
                        },
                          controller:_emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: 'Email',
                            icon: Icon(Icons.mail,color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2.0
                                    )
                                  )
                          ),
                      ),
                      const SizedBox(
                        height: 10,
                        ),
                      TextFormField(
                        textInputAction:TextInputAction.next,
                        validator: (val) => val!.isEmpty 
                        ? "Enter the password"
                        : null,
                        focusNode: focus1,
                        onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus2);
                        },
                            controller: _passEditingController,
                            decoration:  InputDecoration(
                              labelStyle: const TextStyle(color: Colors.black),
                              labelText: 'Password',
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
                            borderSide: BorderSide(
                              width: 2.0),
                              )
                             ),
                             obscureText: _passwordVisible,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    _onRememberChange(value!);
                                  },
                                ),
                                const Flexible(
                                  child: Text('Remember me',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                    minWidth: 80,
                                    height: 30,
                                    child: const Text('Login'),
                                    color: Colors.orange[800],
                                    textColor: Colors.white,
                                    elevation: 10, 
                                  onPressed: _loginUser,
                                ),
                              ]),
                              const SizedBox(
                                height:15
                                ),
                              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Register new account? ",
                    style: TextStyle(fontSize: 16.0)),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegisterPage()))
                  },
                  child: const Text(
                    " Click here",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )))
                      
        ),
    ])));

  }
  void _loginUser(){
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Please fill in the login form",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0
      );
    return;
    }
    
    String _email = _emailEditingController.text;
    String _pass = _passEditingController.text;
    String _type = type;

    ProgressDialog progressDialog = ProgressDialog(context,
      message: const Text("Please wait.."),
      title: const Text("Login User"));
    progressDialog.show();

    http.post(Uri.parse(Config.server + "/annburger/php/login_user.php"),
        body: {
          "email": _email,
          "password": _pass,
          "type": _type,
        }).then((response) {
          if (response.statusCode == 200 && response.body != "failed"){
            final jsonResponse = json.decode(response.body);
            User user = User.fromJson(jsonResponse);
            Fluttertoast.showToast(
              msg: "Login Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0
            );
            progressDialog.dismiss();
            if (_type == 'admin'){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (BuildContext context) =>  MainPage2(user: user,) ));
            }else if (_type == 'user'){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (BuildContext context) =>  MainPage1(user: user,) ));
            }
          }else{
          Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
      progressDialog.dismiss();
    });
  
  }

  void saveremovepref(bool value) async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      _isChecked = false;
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Fluttertoast.showToast(
          msg: "Preference Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailEditingController.text = '';
        _passEditingController.text = '';
        _isChecked = false;
      });
      Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    }
  }
  void _onRememberChange(bool newValue) => setState((){
    _isChecked = newValue;
    if(_isChecked){
      saveremovepref(true);
    }else{
      saveremovepref(false);
    }
  });

  Future<void> loadPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    if (email.length > 1) {
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
        _isChecked = true;
      });
    }
  }
}
