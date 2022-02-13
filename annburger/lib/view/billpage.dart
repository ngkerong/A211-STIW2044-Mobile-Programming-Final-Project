import 'dart:async';
import 'dart:io';
import 'package:annburger/model/config.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class BillPage extends StatefulWidget {

  final String totalprice,email,name;

  const BillPage({Key? key, required this.email, required this.name,required this.totalprice})
      : super(key: key);

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late double screenHeight, screenWidth, resWidth;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill'),
      ),
      body: Center(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: WebView(
            initialUrl: Config.server +
                'annburger/php/payment.php?email=' +
                widget.email.toString() +
                '&name=' +
                widget.name.toString() +
                '&amount=' +
                widget.totalprice.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
          ),
        ),
      ),
    );
  }
}