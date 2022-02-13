import 'dart:async';
import 'package:flutter/material.dart';
import 'package:annburger/view/loginpage.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();

}

class SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
     Timer(const 
     Duration(seconds:3), 
     () => Navigator.pushReplacement(context, 
        MaterialPageRoute(
          builder: (content) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png',),
                    ))),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  const [
              CircularProgressIndicator(),
              Text(
                "All copyright &copy reserved by Ng Ke Rong",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              
            ],
          ),
        )
      ],
    );
  }
}