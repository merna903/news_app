import 'package:flutter/material.dart';
import 'package:news_app/shared/components/constans.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  var webViewController = WebViewController()..loadRequest(Uri.parse(url),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
