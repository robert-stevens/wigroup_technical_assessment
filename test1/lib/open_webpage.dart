import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenWebPageUrl extends StatelessWidget {
  final TextEditingController _textController =
      TextEditingController(text: 'https://');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Open Web Page URL in webview")),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _textController,
            ),
          ),
          RaisedButton(
            child: const Text('Goto Webpage'),
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return WebViewWebPage(url: _textController.text);
              }));
            },
          ),
        ],
      )),
    );
  }
}

class WebViewWebPage extends StatelessWidget {
  final String url;

  WebViewWebPage({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Open Web Page URL in webview")),
      body: WebView(
      initialUrl: url,
        // hidden: true,
        // appBar: AppBar(title: Text("Open Web Page URL in webview")),
      )
    );
  }
}