import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWebPage extends StatelessWidget {
  final String title;
  final String url;

  WebViewWebPage({this.title,this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: WebView(
      initialUrl: url,
        // hidden: true,
        // appBar: AppBar(title: Text("Open Web Page URL in webview")),
      )
    );
  }
}