import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewEx extends StatefulWidget {
  const WebViewEx({Key? key}) : super(key: key);

  @override
  _WebViewExState createState() => _WebViewExState();
}

class _WebViewExState extends State<WebViewEx> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      initialUrl: 'https://hoblist.com',
    ));
  }
}
