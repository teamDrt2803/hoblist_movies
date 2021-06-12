import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewEx extends StatefulWidget {
  const WebViewEx({Key? key}) : super(key: key);

  @override
  _WebViewExState createState() => _WebViewExState();
}

class _WebViewExState extends State<WebViewEx> {
  bool loading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebView(
              onWebViewCreated: (controller) {},
              onPageFinished: (value) {
                setState(() {
                  loading = false;
                });
              },
              onPageStarted: (value) {
                setState(() {
                  loading = true;
                });
              },
              initialUrl: 'https://hoblist.com',
            ),
            if (loading)
              Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }
}
